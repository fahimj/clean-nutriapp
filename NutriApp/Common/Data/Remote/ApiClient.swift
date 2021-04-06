//
//  ApiClient.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 30/12/20.
//

import Foundation
import Alamofire
import RxSwift

enum ApiError: Error, LocalizedError {
    case badRequest(errorMessage:String?)
    case unauthorized(errorMessage:String?)            //Status code 401
    case forbidden(errorMessage:String?)              //Status code 403
    case notFound(errorMessage:String?)               //Status code 404
    case conflict(errorMessage:String?)               //Status code 409
    case internalServerError(errorMessage:String?)    //Status code 500
    case connectionError(errorMessage:String?)
    case timeoutError(errorMessage:String?)
    case unprocessableEntity(errorMessage:String?)
    case otherFailure(errorMessage:String?)
    case connectionOffline
    
    public var errorDescription: String? {
        switch self {
        case .forbidden(let errorMessage):
            return NSLocalizedString(errorMessage ?? "", comment: "")
        case .notFound(let errorMessage):
            return NSLocalizedString(errorMessage ?? "", comment: "")
        case .conflict(let errorMessage):
            return NSLocalizedString(errorMessage ?? "", comment: "")
        case .internalServerError(let errorMessage):
            return NSLocalizedString(errorMessage ?? "Error on server.", comment: "")
        case .connectionError(let errorMessage):
            return NSLocalizedString(errorMessage ?? "", comment: "")
        case .timeoutError(let errorMessage):
            return NSLocalizedString(errorMessage ?? "", comment: "")
        case .unprocessableEntity(let errorMessage):
            return NSLocalizedString(errorMessage ?? "", comment: "")
        case .otherFailure(let errorMessage):
            return NSLocalizedString(errorMessage ?? "", comment: "")
        case .unauthorized(let errorMessage):
            return NSLocalizedString(errorMessage ?? "Sesi Anda telah habis", comment: "401 error")
        default:
            return "Terjadi kesalahan."
        }
    }
}

class ByspassSSLTrustPolicyManager: ServerTrustManager {
    init() {
        super.init(allHostsMustBeEvaluated: false, evaluators: [:])
    }
}

class ApiClient
{
//    static let shared = ApiClient()
    var session:Session!
    private var retriedRequests: [String: Int] = [:]
    
    var apiKey: String = "fc46011919fc4650b727c7a199e68e04" //"41a25a4004924fbe98c7a7f6390d3547"
   
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 120
        configuration.urlCredentialStorage = nil
        let policy = RetryPolicy(retryLimit: RetryPolicy.defaultRetryLimit, exponentialBackoffBase: RetryPolicy.defaultExponentialBackoffBase, exponentialBackoffScale: RetryPolicy.defaultExponentialBackoffScale, retryableHTTPMethods: RetryPolicy.defaultRetryableHTTPMethods, retryableHTTPStatusCodes: [400,401,408,500,502,503,504], retryableURLErrorCodes: RetryPolicy.defaultRetryableURLErrorCodes)
        let composite = Interceptor(adapters: [policy,self], retriers: [policy,self])
        session = Session(interceptor: composite)  // Create a session manager
    }
    
    func sendAsObservable<T: ApiRequest> (_ request: T) -> Observable<T.Response> {
        return Observable.create { observer in
            
            let request = self.send(request, completion: {result in
                observer.onNext(result)
                observer.onCompleted()
            }, errorHandler: {error in
                observer.onError(error)
            })
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    @discardableResult
    public func send<T: ApiRequest>(_ request: T, completion: @escaping (T.Response) -> Void, errorHandler: @escaping (ApiError) -> Void) -> DataRequest {
        let urlRequest = try! request.asURLRequest()

        let request = session.request(urlRequest)
            .debugLog()
            .validate()
            .responseDecodable { (response: DataResponse<T.Response, AFError>) in
                print(response.response?.statusCode ?? "")
                print(String(decoding: response.data ?? "no response data".data(using: .ascii)!, as: UTF8.self))
                guard let statusCode = response.response?.statusCode else {
                    errorHandler(ApiError.otherFailure(errorMessage: response.value.debugDescription))
                    return
                }
                switch statusCode {
                case 200...299: //ok status
                    print(String(decoding: response.data!, as: UTF8.self))
                    completion(try! response.result.get())
                case 300...599:
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let errorResponse = try? decoder.decode(DtoApiError.self, from: response.data ?? "".data(using: .ascii)!)
                    let errorMessage = errorResponse?.message
                    switch response.response!.statusCode{
                    case 400:
                        errorHandler(ApiError.badRequest(errorMessage: errorMessage))
                    case 401:
                        errorHandler(ApiError.unauthorized(errorMessage: errorMessage))
                    case 403:
                        errorHandler(ApiError.forbidden(errorMessage: errorMessage))
                    case 404:
                        errorHandler(ApiError.notFound(errorMessage: errorMessage))
                    case 409:
                        errorHandler(ApiError.conflict(errorMessage: errorMessage))
                    case 422:
                        errorHandler(ApiError.unprocessableEntity(errorMessage: errorMessage))
                    case 500:
                        errorHandler(ApiError.internalServerError(errorMessage: errorMessage))
                    default:
                        errorHandler(ApiError.otherFailure(errorMessage: "other error"))
                    }
                default:
                    errorHandler(ApiError.otherFailure(errorMessage: "other error"))
                }
        }
        return request
    }
}

extension Data {
    func toString() -> String? {
        return String(data: self, encoding: .utf8)
    }
}

extension ApiClient : RequestAdapter {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard var urlComponents = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: false) else {return}
        if urlComponents.queryItems == nil {
            urlComponents.queryItems = []
        }
        urlComponents.queryItems?.append(URLQueryItem(name: "apiKey", value: apiKey))
        var urlRequest = urlRequest
        urlRequest.url = urlComponents.url
        completion(.success(urlRequest))
    }
}

extension ApiClient : RequestRetrier {
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        // versi baru
        guard let statusCode = request.response?.statusCode else {
            completion(.doNotRetry)
            return
        }
        
        if (statusCode != 401) {
            completion(.doNotRetry)
            return
        }
        
        completion(.retry)
    }
}

extension Request {
    public func debugLog() -> Self {
        #if DEBUG
        cURLDescription{print($0)}
        #endif
        return self
    }
}

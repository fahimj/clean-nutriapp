//
//  ApiRequest.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 30/12/20.
//

import Foundation
import Alamofire

protocol ApiRequest
{
    associatedtype Response: Decodable

    var method: HTTPMethod {get}
    var baseUrlString:String {get}
    var path: String {get}
    var parameters: [String: Any] {get}
    var httpBody: Data? {get}
    var parameterHeaders: [String: String] {get}
    var encoding: ParameterEncoding? {get}
}

extension ApiRequest
{
    public func asURLRequest() throws -> URLRequest {
        let baseUrl = try! baseUrlString.asURL()

        var request = URLRequest(url: baseUrl.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(10)

        for (header, value) in parameterHeaders {
            request.addValue(value, forHTTPHeaderField: header)
        }

        if let httpBody = httpBody{
            request.httpBody = httpBody
        }

        if let encoding = encoding {
            return try encoding.encode(request, with: parameters as Parameters)
        } else {
            return request
        }

    }
}

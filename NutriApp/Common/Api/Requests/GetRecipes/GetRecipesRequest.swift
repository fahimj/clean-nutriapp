//
//  GetRecipesRequest.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 30/12/20.
//

import Foundation
import Alamofire

extension Endpoints
{
    struct ListBlockedUserRequest : ApiRequest
    {
        public typealias Response = BaseResponse<ListBlockedUserResponse>
        let page:Int
        let perPage:Int
        
        init(page:Int = 1, perPage:Int = 10 ) {
            self.page = page
            self.perPage = perPage
        }
        
        var baseUrlString: String {
            return Endpoints.baseUrl
        }
        
        var method: HTTPMethod{
            return .get
        }
        
        var path: String {
            return "v1/users/blocked"
        }
        
        var parameters: [String : Any] {
            return [ //page=1&per_page=25
                "page" : page,
//                "per_page" : perPage
            ]
        }
        
        var httpBody: Data? {
            return nil
        }
        
        var parameterHeaders: [String : String] {
            return [:]
        }
        
        var encoding: ParameterEncoding? {
            return URLEncoding.default
        }
        
    }
}

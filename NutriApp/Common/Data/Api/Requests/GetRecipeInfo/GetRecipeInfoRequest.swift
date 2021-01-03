//
//  GetRecipeInfoRequest.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 30/12/20.
//

import Foundation
import Alamofire

extension Endpoints
{
    struct GetRecipeInfoRequest : ApiRequest
    {
        public typealias Response = DtoRecipeInfo
        let id:Int
        
        init(id:Int) {
            self.id = id
        }
        
        var baseUrlString: String {
            return Endpoints.baseUrl
        }
        
        var method: HTTPMethod{
            return .get
        }
        
        var path: String {
            return "recipes/\(id)/information"
        }
        
        var parameters: [String : Any] {
            return [
                :
            ]
        }
        
        var httpBody: Data? {
            return nil
        }
        
        var parameterHeaders: [String : String] {
            return [:]
        }
        
        var encoding: ParameterEncoding? {
            return URLEncoding.queryString
        }
        
    }
}

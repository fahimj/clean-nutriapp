//
//  SearchRecipesRequest.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 30/12/20.
//

import Foundation
import Alamofire

extension Endpoints
{
    struct SearchRecipesRequest : ApiRequest
    {
        public typealias Response = DtoSearchRecipesResponse
        let query:String
        let offset:Int
        let number:Int
        
        init(query:String, offset:Int = 0, number:Int = 25) {
            self.offset = offset
            self.number = number
            self.query = query
        }
        
        var baseUrlString: String {
            return Endpoints.baseUrl
        }
        
        var method: HTTPMethod{
            return .get
        }
        
        var path: String {
            return "recipes/complexSearch"
        }
        
        var parameters: [String : Any] {
            return [
                "query" : query,
                "offset" : offset,
                "number" : number
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

//
//  DtoApiError.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 30/12/20.
//

import Foundation

struct DtoApiError : Codable {

    let code : Int?
    let link : String?
    let message : String?
    let status : Int?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case link = "link"
        case message = "message"
        case status = "status"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        link = try values.decodeIfPresent(String.self, forKey: .link)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }


}

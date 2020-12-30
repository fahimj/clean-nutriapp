//
//  BaseResponse.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 30/12/20.
//

import Foundation

struct BaseResponse<T:Codable> : Codable {

    let codeStatus : Int?
    let codeStatusMessage : String?
    let data : T?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
    }

    enum StatusCodingKeys: String, CodingKey {
        case codeStatus = "code"
        case codeStatusMessage = "message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try! decoder.container(keyedBy: CodingKeys.self)
        
        let statusContainer = try! values.nestedContainer(keyedBy: StatusCodingKeys.self, forKey: .status)
        codeStatus = try! statusContainer.decodeIfPresent(Int.self, forKey: .codeStatus)
        codeStatusMessage = try! statusContainer.decodeIfPresent(String.self, forKey: .codeStatusMessage)
        
        do {
            data = try values.decodeIfPresent(T.self, forKey: .data)
        } catch {
            data = nil
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        var statusContainer = values.nestedContainer(keyedBy: StatusCodingKeys.self, forKey: .status)
        try! statusContainer.encode(codeStatus, forKey: .codeStatus)
        try! statusContainer.encode(codeStatusMessage, forKey: .codeStatusMessage)

        try! values.encode(data, forKey: .data)
    }
}

//
//  GetRecipesResponse.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 30/12/20.
//

import Foundation

struct ListBlockedUserResponse : Codable {

    let currentPage : Int?
    let data : [BlockUserData]?
    let firstPageUrl : String?
    let from : Int?
    let lastPage : Int?
    let lastPageUrl : String?
    let nextPageUrl : String?
    let path : String?
    let perPage : Int?
    let prevPageUrl : String?
    let to : Int?
    let total : Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data = "data"
        case firstPageUrl = "first_page_url"
        case from = "from"
        case lastPage = "last_page"
        case lastPageUrl = "last_page_url"
        case nextPageUrl = "next_page_url"
        case path = "path"
        case perPage = "per_page"
        case prevPageUrl = "prev_page_url"
        case to = "to"
        case total = "total"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        currentPage = try values.decodeIfPresent(Int.self, forKey: .currentPage)
        data = try values.decodeIfPresent([BlockUserData].self, forKey: .data)
        firstPageUrl = try values.decodeIfPresent(String.self, forKey: .firstPageUrl)
        from = try values.decodeIfPresent(Int.self, forKey: .from)
        lastPage = try values.decodeIfPresent(Int.self, forKey: .lastPage)
        lastPageUrl = try values.decodeIfPresent(String.self, forKey: .lastPageUrl)
        nextPageUrl = try values.decodeIfPresent(String.self, forKey: .nextPageUrl)
        path = try values.decodeIfPresent(String.self, forKey: .path)
        perPage = try values.decodeIfPresent(Int.self, forKey: .perPage)
        prevPageUrl = try values.decodeIfPresent(String.self, forKey: .prevPageUrl)
        to = try values.decodeIfPresent(Int.self, forKey: .to)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
    }


}

//
//    Data.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct BlockUserData : Codable {

    let blocked : BlockedUser?
    let blocker : BlockedUser?
    let blocksId : Int?


    enum CodingKeys: String, CodingKey {
        case blocked
        case blocker
        case blocksId = "blocks_id"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        blocked = try values.decodeIfPresent(BlockedUser.self, forKey: .blocked)
        blocker = try values.decodeIfPresent(BlockedUser.self, forKey: .blocker)
        blocksId = try values.decodeIfPresent(Int.self, forKey: .blocksId)
    }

}

//
//    BlockedUser.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct BlockedUser : Codable {

    let dgUsersId : String?
    let meta : BlockedUserMeta?
    let qiscusUsersId : String?
    let usersId : Int?

    enum CodingKeys: String, CodingKey {
        case dgUsersId = "dg_users_id"
        case meta
        case qiscusUsersId = "qiscus_users_id"
        case usersId = "users_id"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dgUsersId = try values.decodeIfPresent(String.self, forKey: .dgUsersId)
        meta = try values.decodeIfPresent(BlockedUserMeta.self, forKey: .meta)
        qiscusUsersId = try values.decodeIfPresent(String.self, forKey: .qiscusUsersId)
        usersId = try values.decodeIfPresent(Int.self, forKey: .usersId)
    }
}


//
//    BlockedUserMeta.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct BlockedUserMeta : Codable {

    let avatar : String?
    let fullname : String?

    enum CodingKeys: String, CodingKey {
        case avatar = "avatar"
        case fullname = "fullname"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
        fullname = try values.decodeIfPresent(String.self, forKey: .fullname)
    }
}

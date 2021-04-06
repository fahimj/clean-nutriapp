//
//  SearchRecipesResponse.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 30/12/20.
//

import Foundation

struct DtoSearchRecipesResponse : Codable {

    let number : Int?
    let offset : Int?
    let results : [DtoSearchResult]?
    let totalResults : Int?

    enum CodingKeys: String, CodingKey {
        case number = "number"
        case offset = "offset"
        case results = "results"
        case totalResults = "totalResults"
    }
    
    init() {
        number = nil
        offset = nil
        results = nil
        totalResults = nil
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        number = try values.decodeIfPresent(Int.self, forKey: .number)
        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
        results = try values.decodeIfPresent([DtoSearchResult].self, forKey: .results)
        totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)
    }
}

struct DtoSearchResult : Codable {
    let id : Int?
    let image : String?
    let imageType : String?
    let title : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case image = "image"
        case imageType = "imageType"
        case title = "title"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        imageType = try values.decodeIfPresent(String.self, forKey: .imageType)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
}

extension DtoSearchRecipesResponse {
    func mapToRecipeList() -> [Recipe] {
        let recipeList = results?.map{searchResult -> Recipe in
            let domain = Recipe(analyzedInstructions: nil, dishTypes: nil, extendedIngredients: nil, id: searchResult.id ?? 0, image: searchResult.image, instructions: nil, sourceUrl: nil, summary: nil, title: searchResult.title ?? "", isFavorite: false)
            return domain
        } ?? []
        
        return recipeList
    }
}

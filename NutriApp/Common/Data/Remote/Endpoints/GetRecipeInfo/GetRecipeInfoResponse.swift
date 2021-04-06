//
//  GetRecipeInfoResponse.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 30/12/20.
//

import Foundation

struct DtoRecipeInfo : Codable {

    let aggregateLikes : Int?
    let analyzedInstructions : [DtoAnalyzedInstruction]?
    let cheap : Bool?
    let cookingMinutes : Int?
    let creditsText : String?
    let cuisines : [String]?
    let dairyFree : Bool?
    let diets : [String]?
    let dishTypes : [String]?
    let extendedIngredients : [DtoExtendedIngredient]?
    let gaps : String?
    let glutenFree : Bool?
    let healthScore : Float?
    let id : Int?
    let image : String?
    let imageType : String?
    let instructions : String?
    let license : String?
    let lowFodmap : Bool?
    let occasions : [String]?
    let originalId : String?
    let preparationMinutes : Int?
    let pricePerServing : Float?
    let readyInMinutes : Int?
    let servings : Int?
    let sourceName : String?
    let sourceUrl : String?
    let spoonacularScore : Float?
    let spoonacularSourceUrl : String?
    let summary : String?
    let sustainable : Bool?
    let title : String?
    let vegan : Bool?
    let vegetarian : Bool?
    let veryHealthy : Bool?
    let veryPopular : Bool?
    let weightWatcherSmartPoints : Int?
    let winePairing : DtoWinePairing?

    enum CodingKeys: String, CodingKey {
        case aggregateLikes = "aggregateLikes"
        case analyzedInstructions = "analyzedInstructions"
        case cheap = "cheap"
        case cookingMinutes = "cookingMinutes"
        case creditsText = "creditsText"
        case cuisines = "cuisines"
        case dairyFree = "dairyFree"
        case diets = "diets"
        case dishTypes = "dishTypes"
        case extendedIngredients = "extendedIngredients"
        case gaps = "gaps"
        case glutenFree = "glutenFree"
        case healthScore = "healthScore"
        case id = "id"
        case image = "image"
        case imageType = "imageType"
        case instructions = "instructions"
        case license = "license"
        case lowFodmap = "lowFodmap"
        case occasions = "occasions"
        case originalId = "originalId"
        case preparationMinutes = "preparationMinutes"
        case pricePerServing = "pricePerServing"
        case readyInMinutes = "readyInMinutes"
        case servings = "servings"
        case sourceName = "sourceName"
        case sourceUrl = "sourceUrl"
        case spoonacularScore = "spoonacularScore"
        case spoonacularSourceUrl = "spoonacularSourceUrl"
        case summary = "summary"
        case sustainable = "sustainable"
        case title = "title"
        case vegan = "vegan"
        case vegetarian = "vegetarian"
        case veryHealthy = "veryHealthy"
        case veryPopular = "veryPopular"
        case weightWatcherSmartPoints = "weightWatcherSmartPoints"
        case winePairing
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        aggregateLikes = try values.decodeIfPresent(Int.self, forKey: .aggregateLikes)
        analyzedInstructions = try values.decodeIfPresent([DtoAnalyzedInstruction].self, forKey: .analyzedInstructions)
        cheap = try values.decodeIfPresent(Bool.self, forKey: .cheap)
        cookingMinutes = try values.decodeIfPresent(Int.self, forKey: .cookingMinutes)
        creditsText = try values.decodeIfPresent(String.self, forKey: .creditsText)
        cuisines = try values.decodeIfPresent([String].self, forKey: .cuisines)
        dairyFree = try values.decodeIfPresent(Bool.self, forKey: .dairyFree)
        diets = try values.decodeIfPresent([String].self, forKey: .diets)
        dishTypes = try values.decodeIfPresent([String].self, forKey: .dishTypes)
        extendedIngredients = try values.decodeIfPresent([DtoExtendedIngredient].self, forKey: .extendedIngredients)
        gaps = try values.decodeIfPresent(String.self, forKey: .gaps)
        glutenFree = try values.decodeIfPresent(Bool.self, forKey: .glutenFree)
        healthScore = try values.decodeIfPresent(Float.self, forKey: .healthScore)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        imageType = try values.decodeIfPresent(String.self, forKey: .imageType)
        instructions = try values.decodeIfPresent(String.self, forKey: .instructions)
        license = try values.decodeIfPresent(String.self, forKey: .license)
        lowFodmap = try values.decodeIfPresent(Bool.self, forKey: .lowFodmap)
        occasions = try values.decodeIfPresent([String].self, forKey: .occasions)
        originalId = try values.decodeIfPresent(String.self, forKey: .originalId)
        preparationMinutes = try values.decodeIfPresent(Int.self, forKey: .preparationMinutes)
        pricePerServing = try values.decodeIfPresent(Float.self, forKey: .pricePerServing)
        readyInMinutes = try values.decodeIfPresent(Int.self, forKey: .readyInMinutes)
        servings = try values.decodeIfPresent(Int.self, forKey: .servings)
        sourceName = try values.decodeIfPresent(String.self, forKey: .sourceName)
        sourceUrl = try values.decodeIfPresent(String.self, forKey: .sourceUrl)
        spoonacularScore = try values.decodeIfPresent(Float.self, forKey: .spoonacularScore)
        spoonacularSourceUrl = try values.decodeIfPresent(String.self, forKey: .spoonacularSourceUrl)
        summary = try values.decodeIfPresent(String.self, forKey: .summary)
        sustainable = try values.decodeIfPresent(Bool.self, forKey: .sustainable)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        vegan = try values.decodeIfPresent(Bool.self, forKey: .vegan)
        vegetarian = try values.decodeIfPresent(Bool.self, forKey: .vegetarian)
        veryHealthy = try values.decodeIfPresent(Bool.self, forKey: .veryHealthy)
        veryPopular = try values.decodeIfPresent(Bool.self, forKey: .veryPopular)
        weightWatcherSmartPoints = try values.decodeIfPresent(Int.self, forKey: .weightWatcherSmartPoints)
        winePairing = try DtoWinePairing(from: decoder)
    }
}

struct DtoWinePairing : Codable {

    let pairedWines : [String]?
    let pairingText : String?
    let productMatches : [DtoProductMatch]?


    enum CodingKeys: String, CodingKey {
        case pairedWines = "pairedWines"
        case pairingText = "pairingText"
        case productMatches = "productMatches"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pairedWines = try values.decodeIfPresent([String].self, forKey: .pairedWines)
        pairingText = try values.decodeIfPresent(String.self, forKey: .pairingText)
        productMatches = try values.decodeIfPresent([DtoProductMatch].self, forKey: .productMatches)
    }
}

struct DtoProductMatch : Codable {

    let averageRating : Float?
    let descriptionField : String?
    let id : Int?
    let imageUrl : String?
    let link : String?
    let price : String?
    let ratingCount : Float?
    let score : Float?
    let title : String?


    enum CodingKeys: String, CodingKey {
        case averageRating = "averageRating"
        case descriptionField = "description"
        case id = "id"
        case imageUrl = "imageUrl"
        case link = "link"
        case price = "price"
        case ratingCount = "ratingCount"
        case score = "score"
        case title = "title"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        averageRating = try values.decodeIfPresent(Float.self, forKey: .averageRating)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        link = try values.decodeIfPresent(String.self, forKey: .link)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        ratingCount = try values.decodeIfPresent(Float.self, forKey: .ratingCount)
        score = try values.decodeIfPresent(Float.self, forKey: .score)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
}

struct DtoExtendedIngredient : Codable {

    let aisle : String?
    let amount : Float?
    let consistency : String?
    let id : Int?
    let image : String?
    let measures : DtoMeasure?
    let meta : [String]?
    let metaInformation : [String]?
    let name : String?
    let original : String?
    let originalName : String?
    let originalString : String?
    let unit : String?


    enum CodingKeys: String, CodingKey {
        case aisle = "aisle"
        case amount = "amount"
        case consistency = "consistency"
        case id = "id"
        case image = "image"
        case measures
        case meta = "meta"
        case metaInformation = "metaInformation"
        case name = "name"
        case original = "original"
        case originalName = "originalName"
        case originalString = "originalString"
        case unit = "unit"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        aisle = try values.decodeIfPresent(String.self, forKey: .aisle)
        amount = try values.decodeIfPresent(Float.self, forKey: .amount)
        consistency = try values.decodeIfPresent(String.self, forKey: .consistency)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        measures = try DtoMeasure(from: decoder)
        meta = try values.decodeIfPresent([String].self, forKey: .meta)
        metaInformation = try values.decodeIfPresent([String].self, forKey: .metaInformation)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        original = try values.decodeIfPresent(String.self, forKey: .original)
        originalName = try values.decodeIfPresent(String.self, forKey: .originalName)
        originalString = try values.decodeIfPresent(String.self, forKey: .originalString)
        unit = try values.decodeIfPresent(String.self, forKey: .unit)
    }
}

struct DtoMeasure : Codable {

    let metric : DtoMetric?
    let us : DtoMetric?


    enum CodingKeys: String, CodingKey {
        case metric
        case us
    }
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: CodingKeys.self)
        metric = try DtoMetric(from: decoder)
        us = try DtoMetric(from: decoder)
    }
}

struct DtoMetric : Codable {

    let amount : Float?
    let unitLong : String?
    let unitShort : String?


    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case unitLong = "unitLong"
        case unitShort = "unitShort"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        amount = try values.decodeIfPresent(Float.self, forKey: .amount)
        unitLong = try values.decodeIfPresent(String.self, forKey: .unitLong)
        unitShort = try values.decodeIfPresent(String.self, forKey: .unitShort)
    }
}

struct DtoAnalyzedInstruction : Codable {

    let name : String?
    let steps : [DtoStep]?


    enum CodingKeys: String, CodingKey {
        case name = "name"
        case steps = "steps"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        steps = try values.decodeIfPresent([DtoStep].self, forKey: .steps)
    }
}

struct DtoEquipment : Codable {

    let id : Int?
    let image : String?
    let localizedName : String?
    let name : String?


    enum CodingKeys: String, CodingKey {
        case id = "id"
        case image = "image"
        case localizedName = "localizedName"
        case name = "name"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        localizedName = try values.decodeIfPresent(String.self, forKey: .localizedName)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }


}

struct DtoStep : Codable {

    let equipment : [DtoEquipment]?
    let ingredients : [DtoIngredient]?
    let number : Int?
    let step : String?


    enum CodingKeys: String, CodingKey {
        case equipment = "equipment"
        case ingredients = "ingredients"
        case number = "number"
        case step = "step"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        equipment = try values.decodeIfPresent([DtoEquipment].self, forKey: .equipment)
        ingredients = try values.decodeIfPresent([DtoIngredient].self, forKey: .ingredients)
        number = try values.decodeIfPresent(Int.self, forKey: .number)
        step = try values.decodeIfPresent(String.self, forKey: .step)
    }
}

struct DtoIngredient : Codable {

    let id : Int?
    let image : String?
    let localizedName : String?
    let name : String?


    enum CodingKeys: String, CodingKey {
        case id = "id"
        case image = "image"
        case localizedName = "localizedName"
        case name = "name"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        localizedName = try values.decodeIfPresent(String.self, forKey: .localizedName)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }


}

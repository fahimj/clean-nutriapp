//
//  RecipeDetails.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 31/12/20.
//

import Foundation

struct Recipe {
    let analyzedInstructions : [String]?
    let dishTypes : [String]?
    let extendedIngredients : [String]?
    let id : Int
    let image : String?
    let instructions : [String]?
    let sourceUrl : String?
    let summary : String?
    let title : String
    var isFavorite : Bool
}

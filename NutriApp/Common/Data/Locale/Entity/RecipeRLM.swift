//
//  RLMRecipe.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 31/12/20.
//

import Foundation
import RealmSwift

class RecipeRLM : Object {
    let analyzedInstructions = List<String>()
    let dishTypes = List<String>()
    let extendedIngredients = List<String>()
    @objc dynamic var id : Int
    @objc dynamic var image : String = ""
    let instructions  = List<String>()
    @objc dynamic var sourceUrl : String
    @objc dynamic var summary : String
    @objc dynamic var title : String
    @objc dynamic var isFavorite : Bool
    
    public override static func primaryKey() -> String? {
      return "id"
    }
    
    required public override init() {
        id = 0
        image = ""
        sourceUrl = ""
        summary = ""
        title = ""
        isFavorite = false
    }
    
    public convenience init(analyzedInstructions: [String], dishTypes: [String], extendedIngredients: [String], id: Int, image: String, instructions: [String], sourceUrl: String, summary: String, title: String, isFavorite:Bool) {
        self.init()
        self.analyzedInstructions.append(objectsIn: analyzedInstructions)
        self.dishTypes.append(objectsIn: dishTypes)
        self.extendedIngredients.append(objectsIn: extendedIngredients)
        self.id = id
        self.image = image
        self.instructions.append(objectsIn: instructions)
        self.sourceUrl = sourceUrl
        self.summary = summary
        self.title = title
        self.isFavorite = isFavorite
    }
    
    func mapToDomain() -> Recipe {
        let recipe = Recipe(analyzedInstructions: analyzedInstructions.toArray(), dishTypes: dishTypes.toArray(), extendedIngredients: extendedIngredients.toArray(), id: id, image: image, instructions: instructions.toArray(), sourceUrl: sourceUrl, summary: summary, title: title, isFavorite: isFavorite)
        return recipe
    }
    
    static func mapToRealmModel(recipe: Recipe) -> RecipeRLM {
        let recipeRlm = RecipeRLM(analyzedInstructions: recipe.analyzedInstructions ?? [], dishTypes: recipe.dishTypes ?? [], extendedIngredients: recipe.extendedIngredients ?? [], id: recipe.id, image: recipe.image ?? "", instructions: recipe.instructions ?? [], sourceUrl: recipe.sourceUrl ?? "", summary: recipe.summary ?? "", title: recipe.title, isFavorite: recipe.isFavorite)
        
        return recipeRlm
    }
}

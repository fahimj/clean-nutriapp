//
//  GetRecipeInfo+DomainMapper.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 31/12/20.
//

import Foundation

extension DtoRecipeInfo {
    func mapToRecipe() -> Recipe {
        let instructionList = self.analyzedInstructions?
            .first.map{instructions -> [String] in
                return (instructions.steps?.map{$0.step ?? ""} ?? [])
            }
        
        let ingredientList = self.extendedIngredients?.map{ingredient -> String in
            ingredient.originalString ?? ""
        }
        
        let recipe = Recipe(analyzedInstructions: instructionList, dishTypes: dishTypes ?? [], extendedIngredients: ingredientList ?? [], id: id ?? 0, image: image, instructions: instructionList ?? [], sourceUrl: sourceUrl, summary: summary ?? "", title: title ?? "", isFavorite: false)
        
        return recipe
    }
}

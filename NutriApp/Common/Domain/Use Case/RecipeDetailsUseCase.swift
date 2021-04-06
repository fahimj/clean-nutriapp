//
//  RecipeDetailsUseCaes.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 02/01/21.
//

import Foundation
import RxSwift

protocol RecipeDetailsUseCaseProtocol {
    func getRecipeDetails(recipe:Recipe) -> Observable<Recipe>
    func addToFavorites(recipe: Recipe) -> Observable<Recipe>
    func removeFromFavorites(recipe: Recipe) -> Observable<Recipe>
}

class RecipeDetailsUseCase : RecipeDetailsUseCaseProtocol{
    
    private let repository: RecipeRepositoryProtocol

    required init(repository: RecipeRepositoryProtocol) {
        self.repository = repository
    }
    
    func getRecipeDetails(recipe:Recipe) -> Observable<Recipe> {
        if recipe.instructions?.isEmpty ?? false {
            return self.repository.getRecipeDetails(id: recipe.id)
        }
        
        return Observable.just(recipe)
        
    }
    
    func addToFavorites(recipe: Recipe) -> Observable<Recipe>  {
        var editedRecipe = recipe
        editedRecipe.isFavorite = true
        return self.repository.editRecipe(recipe: editedRecipe)
    }
    
    func removeFromFavorites(recipe: Recipe) -> Observable<Recipe>  {
        var editedRecipe = recipe
        editedRecipe.isFavorite = false
        return self.repository.editRecipe(recipe: editedRecipe)
    }
    
}

//
//  RecipeRepository.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 31/12/20.
//

import Foundation
import RxSwift

protocol RecipeRepositoryProtocol {
    func getRecipes(query:String) -> Observable<[Recipe]>
    func getFavoriteRecipes() -> Observable<[Recipe]>
    func getRecipe(id:Int) -> Observable<Recipe?>
    func syncMoreRecipes(query:String, offset:Int, perPage:Int) -> Observable<Void>
    func getRecipeDetails(id:Int) -> Observable<Recipe>
    func editRecipe(recipe:Recipe) -> Observable<Recipe>
}

final class RecipeRepository  {
    typealias RecipeRepoInstance = (LocaleDataSourceProtocol, RemoteDataSourceProtocol) -> RecipeRepository
    
    fileprivate let remote: RemoteDataSourceProtocol
    fileprivate let locale: LocaleDataSourceProtocol
    
    let disposeBag = DisposeBag()
    
     init(locale: LocaleDataSourceProtocol, remote: RemoteDataSourceProtocol) {
        self.locale = locale
        self.remote = remote
    }
    
    public static let createInstance: RecipeRepoInstance = { localeRepo, remoteRepo in
        return RecipeRepository(locale: localeRepo, remote: remoteRepo)
    }
}

extension RecipeRepository : RecipeRepositoryProtocol {
    func getFavoriteRecipes() -> Observable<[Recipe]> {
        return locale.getObjects(RecipeRLM.self, predicate: "isFavorite = true")
            .map{recipes in
                recipes.map{$0.mapToDomain()}
            }
    }
    
    func getRecipeDetails(id: Int) -> Observable<Recipe> {
        let recipeDetailsStream = remote.getRecipeDetails(id: id)
            .map{$0.mapToRecipe()}
        
        let recipeLocalStream = locale.getObject(RecipeRLM.self, key: id)
        
        // get recipe details, then save to local
        return Observable.combineLatest(recipeDetailsStream, recipeLocalStream)
            .map{recipeRemote, recipeLocal -> RecipeRLM in
                var editedRecipeDetails = recipeRemote
                editedRecipeDetails.isFavorite = recipeLocal?.isFavorite ?? false
                return RecipeRLM.mapToRealmModel(recipe: editedRecipeDetails)
            }
            .flatMap{[weak self] recipeDetails -> Observable<RecipeRLM>  in
                return self!.locale.add(recipeDetails, update: true)
            }
            .map{$0.mapToDomain()}
    }
    
    func getRecipes(query:String) -> Observable<[Recipe]> {
        return locale.getRecipes(query: query)
            .map{recipes in
                recipes.map{$0.mapToDomain()}
            }
    }
    
    func getRecipe(id:Int) -> Observable<Recipe?> {
        return locale.getObject(RecipeRLM.self, key: id)
            .map{recipes in
                recipes.map{$0.mapToDomain()}
            }
    }
    
    func syncMoreRecipes(query:String, offset:Int, perPage:Int) -> Observable<Void> {
        let favoritedRecipesStream = locale.getFavoritedRecipes()
        let getRecipesStream = remote.getRecipes(query: query, offset: offset, perPage: perPage)
            .catchErrorJustReturn(DtoSearchRecipesResponse())
        
        
        return Observable.zip(favoritedRecipesStream, getRecipesStream)
            .flatMap{ [weak self] favoritedRecipes, recipesResponse -> Observable<[RecipeRLM]> in
                //keep isFavorite value for each model
                let recipeList = recipesResponse.mapToRecipeList()
                let models = recipeList.map{RecipeRLM.mapToRealmModel(recipe: $0)}
                models.forEach{model in
                    let favoriteValue = favoritedRecipes.contains(where: {$0.id == model.id})
                    model.isFavorite = favoriteValue
                }
                
                return self!.locale.add(models, update: true)
            }
            .map{_ in return ()}
    }
    
    func editRecipe(recipe:Recipe) -> Observable<Recipe> {
        Observable.just(recipe)
            .map{recipe -> RecipeRLM in
//                guard let recipeRlm = recipeRlm else {throw DatabaseError.requestFailed}
                let recipeRlm = RecipeRLM.mapToRealmModel(recipe: recipe)
                recipeRlm.isFavorite = recipe.isFavorite
                recipeRlm.title = recipe.title
                recipeRlm.image = recipe.image ?? ""
                recipeRlm.sourceUrl = recipe.sourceUrl ?? ""
                recipeRlm.summary = recipe.summary ?? ""
                
                recipeRlm.instructions.removeAll()
                recipeRlm.instructions.append(objectsIn: recipe.instructions ?? [])
                
                recipeRlm.extendedIngredients.removeAll()
                recipeRlm.extendedIngredients.append(objectsIn: recipe.extendedIngredients ?? [])
                
                return recipeRlm
            }
            .flatMap{[weak self] recipeRlm -> Observable<RecipeRLM> in
                return self!.locale.add(recipeRlm, update: true)
            }
            .map{$0.mapToDomain()}
            
    }
}

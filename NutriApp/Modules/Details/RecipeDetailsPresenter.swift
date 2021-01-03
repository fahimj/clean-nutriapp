//
//  RecipeDetailsPresenter.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 02/01/21.
//

import Foundation
import RxSwift
import RxRelay

final class RecipeDetailsPresenter {
    let title: BehaviorRelay<String> = BehaviorRelay(value: "")
    let summary: BehaviorRelay<String> = BehaviorRelay(value: "")
    let instructions: BehaviorRelay<String> = BehaviorRelay(value: "")
    let ingredients: BehaviorRelay<String> = BehaviorRelay(value: "")
    let imageUrl: BehaviorRelay<String> = BehaviorRelay(value: "")
    let isFavorite: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let isLoading: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let disposeBag = DisposeBag()
    
    let recipe: Recipe
    let useCase: RecipeDetailsUseCaseProtocol
    
    init(recipe:Recipe, useCase:RecipeDetailsUseCaseProtocol) {
        self.recipe = recipe
        self.useCase = useCase
        setupRx()
    }
    
    private func setupRx() {
        let recipeStream = useCase.getRecipeDetails(recipe: recipe).share()
        
        recipeStream
            .map{_ in false}
            .catchErrorJustReturn(false)
            .bind(to: isLoading)
            .disposed(by: disposeBag)
        
        recipeStream
            .map{$0.title}
            .catchErrorJustReturn("")
            .bind(to: title).disposed(by: disposeBag)
        
        recipeStream
            .map{$0.summary ?? ""}
            .catchErrorJustReturn("")
            .bind(to: summary)
            .disposed(by: disposeBag)
                                  
        recipeStream
            .map{$0.image ?? ""}
            .catchErrorJustReturn("")
            .bind(to: imageUrl)
            .disposed(by: disposeBag)
                                  
        recipeStream
            .map{$0.isFavorite}
            .catchErrorJustReturn(false)
            .bind(to: isFavorite)
            .disposed(by: disposeBag)
        
        recipeStream
            .map{recipe in
                let output = recipe.instructions?.reduce("<ul>") {initial, next in
                     initial + "<li>" + next + "</li>"
                } ?? ""
                return output + "</ul>"
            }
            .catchErrorJustReturn("")
            .bind(to: instructions).disposed(by: disposeBag)
        
        recipeStream
            .map{recipe in
                return recipe.extendedIngredients?.reduce("") {initial, next in
                    initial + "\n" + next
                } ?? ""
            }
            .catchErrorJustReturn("")
            .bind(to: ingredients).disposed(by: disposeBag)
        
        isFavorite
            .skip(2)
            .flatMap{[weak self] value -> Observable<Recipe> in
                if (value) {
                    return self!.useCase.addToFavorites(recipe: self!.recipe)
                } else {
                    return self!.useCase.removeFromFavorites(recipe: self!.recipe)
                }
            }
            .subscribe(onNext: {recipe in
                print("recipe updated")
            }, onError: {error in
                print("error happened")
            })
            .disposed(by: disposeBag)
    }
}

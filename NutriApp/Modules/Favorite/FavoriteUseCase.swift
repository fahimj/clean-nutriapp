//
//  FavoriteUseCase.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 02/01/21.
//

import Foundation
import RxSwift

protocol FavoriteUseCaseProtocol {
    func getFavoriteRecipes() -> Observable<[Recipe]>
}

class FavoriteUseCase: FavoriteUseCaseProtocol {
    
    private let repository: RecipeRepositoryProtocol
    
    required init(repository: RecipeRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavoriteRecipes() -> Observable<[Recipe]> {
        return repository.getFavoriteRecipes()
    }
}


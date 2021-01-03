//
//  HomeUseCase.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 31/12/20.
//

import Foundation
import RxSwift

protocol HomeUseCaseProtocol {
    func getRecipes(query: String, offset:Int) -> Observable<[Recipe]>
    func syncMoreRecipes(query: String, offset:Int) -> Observable<Void>
}

class HomeUseCase: HomeUseCaseProtocol {
    
    private let repository: RecipeRepositoryProtocol
    
    required init(repository: RecipeRepositoryProtocol) {
        self.repository = repository
    }
    
    func getRecipes(query: String, offset:Int) -> Observable<[Recipe]> {
        return repository.getRecipes(query: query)
    }
    
    func syncMoreRecipes(query: String, offset:Int) -> Observable<Void> {
        return repository.syncMoreRecipes(query: query, offset: offset, perPage: 25)
    }
}


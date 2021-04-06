//
//  FavoritePresenter.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 02/01/21.
//

import Foundation
import RxSwift
import RxCocoa

final class FavoritePresenter {
    let selection: PublishRelay<Int> = PublishRelay<Int>()
    let loadTrigger: PublishRelay<Void> = PublishRelay<Void>()
    
    let recipes: BehaviorRelay<[Recipe]> = BehaviorRelay<[Recipe]>(value: [])
    let isLoading: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    
    private let disposeBag = DisposeBag()
    private let useCase: FavoriteUseCaseProtocol
    private let router: FavoriteRouterProtocol
    private var query = ""
    
    init(homeUseCase: FavoriteUseCaseProtocol, homeRouter: FavoriteRouterProtocol) {
        self.useCase = homeUseCase
        self.router = homeRouter
        setupRx()
    }
    
    private func setupRx() {
        loadTrigger
            .flatMap{ [weak self] _ -> Observable<[Recipe]> in
                guard let self = self else {return Observable.just([])}
                return self.useCase.getFavoriteRecipes()
            }
            .catchErrorJustReturn([])
            .bind(to: recipes)
            .disposed(by: disposeBag)
        
        
        selection
            .withLatestFrom(recipes, resultSelector: {index, recipes in
                return recipes[index]
            })
            .subscribe(onNext: {[weak self] recipe in
                self?.router.toDetailView(for: recipe)
            }, onError: {error in
                print("An error happened")
                print(error)
            })
            .disposed(by: disposeBag)
            
    }
}

//
//  HomePresenter.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 01/01/21.
//

import Foundation
import RxSwift
import RxCocoa

final class HomePresenter {
    let selection: PublishRelay<Int> = PublishRelay<Int>()
    let loadTrigger: PublishRelay<Void> = PublishRelay<Void>()
    let loadMoreTrigger: PublishRelay<Void> = PublishRelay<Void>()
    
    let recipes: BehaviorRelay<[Recipe]> = BehaviorRelay<[Recipe]>(value: [])
    let isLoading: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    
    private let disposeBag = DisposeBag()
    private let homeUseCase: HomeUseCaseProtocol
    private let homeRouter: HomeRouterProtocol
    private var query = ""
    
    init(homeUseCase: HomeUseCaseProtocol, homeRouter: HomeRouterProtocol) {
        self.homeUseCase = homeUseCase
        self.homeRouter = homeRouter
        setupRx()
    }
    
    private func setupRx() {
        loadTrigger
            .flatMap{ [weak self] _ -> Observable<[Recipe]> in
                guard let self = self else {return Observable.just([])}
                return self.homeUseCase.getRecipes(query: self.query, offset: 0)
            }
            .catchErrorJustReturn([])
            .bind(to: recipes)
            .disposed(by: disposeBag)
        
        loadMoreTrigger
            .withLatestFrom(recipes)
            .flatMap{ [weak self] recipes  -> Observable<Void> in
                guard let self = self else {return Observable.just(())}
                self.isLoading.accept(true)
                return self.homeUseCase.syncMoreRecipes(query: self.query, offset: recipes.count)
            }
            .subscribe(onNext: { [weak self] in
                print("load more")
                self?.isLoading.accept(false)
            }, onError: {error in
                
            })
            .disposed(by: disposeBag)
        
        selection
            .withLatestFrom(recipes, resultSelector: {index, recipes in
                return recipes[index]
            })
            .subscribe(onNext: {[weak self] recipe in
                self?.homeRouter.toDetailView(for: recipe)
            }, onError: {error in
                print("An error happened")
                print(error)
            })
            .disposed(by: disposeBag)
            
    }
}

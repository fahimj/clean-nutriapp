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
    let loadTrigger: PublishRelay<String> = PublishRelay<String>()
    let loadMoreTrigger: PublishRelay<String> = PublishRelay<String>()
    
    let recipes: BehaviorRelay<[Recipe]> = BehaviorRelay<[Recipe]>(value: [])
    let isLoading: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    let searchQuery: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
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
        searchQuery.bind(to: loadTrigger).disposed(by: disposeBag)
        searchQuery.bind(to: loadMoreTrigger).disposed(by: disposeBag)
        
        loadTrigger
            .withLatestFrom(searchQuery)
            .flatMap{ [weak self] query -> Observable<[Recipe]> in
                guard let self = self else {return Observable.just([])}
                return self.homeUseCase.getRecipes(query: query, offset: 0)
            }
            .do(onNext:{print("number of recipes: \($0.count)")})
            .catchErrorJustReturn([])
            .bind(to: recipes)
            .disposed(by: disposeBag)
        
        loadMoreTrigger
            .withLatestFrom(searchQuery)
            .withLatestFrom(recipes) {($0,$1)}
            .flatMap{ [weak self] input -> Observable<Void> in
                guard let self = self else {return Observable.just(())}
                self.query = input.0
                self.isLoading.accept(true)
                return self.homeUseCase.syncMoreRecipes(query: input.0, offset: input.1.count)
            }
            .map{[weak self] in self!.query}
            .bind(to: loadTrigger)
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

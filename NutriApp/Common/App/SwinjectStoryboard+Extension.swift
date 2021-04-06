//
//  SwinjectStoryboard+Extension.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 01/01/21.
//

import Foundation
import Swinject
import SwinjectStoryboard
import RealmSwift
 
extension SwinjectStoryboard {
  @objc class func setup() {
    //data
    defaultContainer.register(Realm.self) {_ in try! Realm()}
    defaultContainer.register(LocaleDataSourceProtocol.self) {resolver in
        let realm = resolver.resolve(Realm.self)
        return LocaleDataSource.createInstance(realm)
    }
    defaultContainer.register(ApiClient.self) {_ in ApiClient()}
    defaultContainer.register(RemoteDataSourceProtocol.self) {resolver in
        let apiClient = resolver.resolve(ApiClient.self)
        return RemoteDataSource.createInstance(apiClient!)
    }
    defaultContainer.register(RecipeRepositoryProtocol.self) {resolver in
        let locale = resolver.resolve(LocaleDataSourceProtocol.self)!
        let remote = resolver.resolve(RemoteDataSourceProtocol.self)!
        return RecipeRepository.createInstance(locale,remote)
    }
    
    //Home
    defaultContainer.register(HomeRouterProtocol.self) { _ in
        HomeRouter()
    }
    defaultContainer.register(HomeUseCaseProtocol.self) { resolver in
        let repo = resolver.resolve(RecipeRepositoryProtocol.self)!
        return HomeUseCase(repository: repo)
    }
    defaultContainer.register(HomePresenter.self) { resolver in
        let homeUseCase = resolver.resolve(HomeUseCaseProtocol.self)!
        let homeRouter = resolver.resolve(HomeRouterProtocol.self)!
        return HomePresenter(homeUseCase: homeUseCase, homeRouter: homeRouter)
    }

    defaultContainer.storyboardInitCompleted(HomeViewController.self) { resolver, controller in
        controller.homePresenter = resolver.resolve(HomePresenter.self)
        defaultContainer.register(HomeViewController.self) { _ in
            return controller
        }
    }
    
    //Detail
    defaultContainer.register(RecipeDetailsUseCaseProtocol.self) { resolver in
        let repo = resolver.resolve(RecipeRepositoryProtocol.self)!
        let useCase = RecipeDetailsUseCase(repository: repo)
        return useCase
    }

    defaultContainer.register(RecipeDetailsPresenter.self) { (resolver, selectedRecipe:Recipe) in
        let useCase = resolver.resolve(RecipeDetailsUseCaseProtocol.self)!
        return RecipeDetailsPresenter(recipe: selectedRecipe, useCase: useCase)
    }
    
    //Favorite
    defaultContainer.register(FavoriteRouterProtocol.self) { _ in
        FavoriteRouter()
    }
    defaultContainer.register(FavoriteUseCaseProtocol.self) { resolver in
        let repo = resolver.resolve(RecipeRepositoryProtocol.self)!
        return FavoriteUseCase(repository: repo)
    }
    defaultContainer.register(FavoritePresenter.self) { resolver in
        let homeUseCase = resolver.resolve(FavoriteUseCaseProtocol.self)!
        let homeRouter = resolver.resolve(FavoriteRouterProtocol.self)!
        return FavoritePresenter(homeUseCase: homeUseCase, homeRouter: homeRouter)
    }

    defaultContainer.storyboardInitCompleted(FavoriteViewController.self) { resolver, controller in
        controller.favoritePresenter = resolver.resolve(FavoritePresenter.self)
        defaultContainer.register(FavoriteViewController.self) { _ in
            return controller
        }
    }
  }
}

//
//  HomePresenterTest.swift
//  NutriAppTests
//
//  Created by Fahim Jatmiko on 01/01/21.
//

import Foundation
import Swinject
import XCTest
import Realm
import RealmSwift
import RxSwift
@testable import NutriApp

class HomePresenterTest: XCTestCase {
    let disposeBag = DisposeBag()
    let defaultContainer = Container()

    override func setUpWithError() throws {
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
            DummyHomeRouter()
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
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetData() {
        let expectation = self.expectation(description: "testGetData")
        let locale = defaultContainer.resolve(LocaleDataSourceProtocol.self)!
        let homePresenter = defaultContainer.resolve(HomePresenter.self)!
        
        locale.clearAllData()
            .flatMap{
                homePresenter.recipes.skip(2)
            }
            .subscribe(onNext:{recipes in
                XCTAssert(recipes.count > 0)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        homePresenter.loadTrigger.accept(())
        homePresenter.loadMoreTrigger.accept(())
        
        
        waitForExpectations(timeout: 5000, handler: nil)
    }

    
}

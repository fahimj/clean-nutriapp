//
//  RepoTest.swift
//  NutriAppTests
//
//  Created by Fahim Jatmiko on 01/01/21.
//

import XCTest
import RealmSwift
import RxSwift
@testable import NutriApp

class RepoTest: XCTestCase {
    let disposeBag = DisposeBag()
    let realm = try? Realm()
    let apiClient = ApiClient()
    var localeDataSource: LocaleDataSource!
    var remoteDataSource: RemoteDataSource!
    var repo: RecipeRepository!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        localeDataSource = LocaleDataSource.createInstance(realm)
        remoteDataSource = RemoteDataSource.createInstance(apiClient)
        repo = RecipeRepository.createInstance(localeDataSource, remoteDataSource)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetMoreData() {
        let expectation = self.expectation(description: "testGetByIdRealm")

        localeDataSource
            .clearAllData()
            .flatMap{self.repo.syncMoreRecipes(query: "", offset: 0, perPage: 25)}
            .flatMap{self.repo.syncMoreRecipes(query: "", offset: 25, perPage: 25)}
            .flatMap{self.repo.getRecipes(query: "")}
            .subscribe(onNext: {recipes in
                XCTAssert(recipes.count == 50)
                expectation.fulfill()
            }, onError: {error in
                XCTAssert(false)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        
        waitForExpectations(timeout: 5000, handler: nil)
    }
    
    func testGetFavoriteRecipes() {
        let expectation = self.expectation(description: "testGetFavoriteRecipes")

        localeDataSource
            .clearAllData()
            .flatMap{self.repo.syncMoreRecipes(query: "", offset: 0, perPage: 25)}
            .flatMap{self.repo.syncMoreRecipes(query: "", offset: 25, perPage: 25)}
            .flatMap{self.repo.getFavoriteRecipes()}
            .subscribe(onNext: {recipes in
                XCTAssert(recipes.count == 0)
                expectation.fulfill()
            }, onError: {error in
                XCTAssert(false)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        
        waitForExpectations(timeout: 5000, handler: nil)
    }

    func testGetSameData() {
        let expectation = self.expectation(description: "testGetByIdRealm")

        localeDataSource
            .clearAllData()
            .flatMap{self.repo.syncMoreRecipes(query: "", offset: 0, perPage: 25)}
            .flatMap{self.repo.syncMoreRecipes(query: "", offset: 0, perPage: 25)}
            .flatMap{self.repo.getRecipes(query: "")}
            .subscribe(onNext: {recipes in
                XCTAssert(recipes.count == 25)
                expectation.fulfill()
            }, onError: {error in
                XCTAssert(false)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        
        waitForExpectations(timeout: 5000, handler: nil)
    }

    
}

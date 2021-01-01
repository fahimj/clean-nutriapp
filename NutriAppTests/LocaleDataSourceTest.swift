//
//  LocaleDataSourceTest.swift
//  NutriAppTests
//
//  Created by Fahim Jatmiko on 31/12/20.
//

import XCTest
import RealmSwift
import RxSwift
@testable import NutriApp

class LocaleDataSourceTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDeleteCreateReadRealm() {
        let disposeBag = DisposeBag()
        let realm = try? Realm()
        let localeDataSource: LocaleDataSource = LocaleDataSource.createInstance(realm)
        
        let expectation = self.expectation(description: "testDeleteCreateReadRealm")

        // create a recipe data
        let data = RecipeRLM()
        data.id = 1
        data.title = "testing recipe"
        data.summary = "testing summary"
        
        localeDataSource
            .clearAllData()
            .flatMap{ localeDataSource.add(data) }
            .flatMap{ localeDataSource.getObjects(RecipeRLM.self) }
            .subscribe(onNext: {list in
                XCTAssert(list.count > 0)
                let object = list.first!
                XCTAssert(object.id == 1)
                XCTAssert(object.title == "testing recipe")
                XCTAssert(object.summary == "testing summary")
                expectation.fulfill()
            }, onError: {error in
                expectation.fulfill()

            })
            .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 5000, handler: nil)
    }
    
    func testFilterRealm()  {
        let disposeBag = DisposeBag()
        let realm = try? Realm()
        let localeDataSource: LocaleDataSource = LocaleDataSource.createInstance(realm)
        
        let expectation = self.expectation(description: "testFilterRealm")

        // create a recipe data
        let data1 = RecipeRLM()
        data1.id = 1
        data1.title = "testing recipe"
        
        let data2 = RecipeRLM()
        data2.id = 2
        data2.title = "item2"
        
        let data = [data1, data2]
        
        localeDataSource
            .clearAllData()
            .flatMap{ localeDataSource.add(data) }
            .flatMap{ localeDataSource.getRecipes(query: "item2")}
            .subscribe(onNext: {list in
                XCTAssert(list.count == 1)
                let object = list.first!
                XCTAssert(object.id == 2)
                XCTAssert(object.title == "item2")
                expectation.fulfill()
            }, onError: {error in
                expectation.fulfill()

            })
            .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 5000, handler: nil)
    }
    
    func testGetByIdRealm() {
        let disposeBag = DisposeBag()
        let realm = try? Realm()
        let localeDataSource: LocaleDataSource = LocaleDataSource.createInstance(realm)
        
        let expectation = self.expectation(description: "testGetByIdRealm")

        // create a recipe data
        let data = RecipeRLM()
        data.id = 1
        data.title = "testing recipe"
        
        localeDataSource
            .clearAllData()
            .flatMap{ localeDataSource.add(data) }
            .flatMap{ localeDataSource.getObject(RecipeRLM.self, key: 1)}
            .subscribe(onNext: {object in
                XCTAssert(object?.id == 1)
                XCTAssert(object?.title == "testing recipe")
                expectation.fulfill()
            }, onError: {error in
                expectation.fulfill()

            })
            .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 5000, handler: nil)
    }

    
}

//
//  NutriAppTests.swift
//  NutriAppTests
//
//  Created by Fahim Jatmiko on 30/12/20.
//

import XCTest
@testable import NutriApp

class NutriAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSearchRecipes() {
        let expectation = self.expectation(description: "testSearchRecipes")

        let request = Endpoints.SearchRecipesRequest(query: "")
        ApiClient.shared.send(request, completion: {response in
            print(response)

            XCTAssert(response.number != nil)
            expectation.fulfill()

        }) {error in
            print(error)

            XCTAssert(false)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5000, handler: nil)
    }
    
    func testGetRecipe() {
        let expectation = self.expectation(description: "testGetRecipe")

        let request = Endpoints.GetRecipeInfoRequest(id: 715439)
        ApiClient.shared.send(request, completion: {response in
            print(response)

            XCTAssert(response.id != nil)
            expectation.fulfill()

        }) {error in
            print(error)

            XCTAssert(false)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5000, handler: nil)
    }

}

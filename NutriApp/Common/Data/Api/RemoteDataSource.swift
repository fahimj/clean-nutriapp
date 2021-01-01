//
//  RemoteDataSource.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 31/12/20.
//

import Foundation
import RxSwift

protocol RemoteDataSourceProtocol {
    func getRecipes(query:String, offset:Int, perPage:Int) -> Observable<DtoSearchRecipesResponse>
    func getRecipeDetails(id:Int) -> Observable<DtoRecipeInfo>
}

final class RemoteDataSource: RemoteDataSourceProtocol {
    static let createInstance: (ApiClient) -> RemoteDataSource = { apiClient in
        return RemoteDataSource(apiClient:apiClient)
    }
    
    private init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    var apiClient:ApiClient
    
    func getRecipes(query: String, offset : Int, perPage:Int) -> Observable<DtoSearchRecipesResponse> {
        let getRecipeRequest = Endpoints.SearchRecipesRequest(query:"", offset:offset, number:perPage)
        return apiClient
            .sendAsObservable(getRecipeRequest)
//            .map{result -> [Recipe] in
//                result.mapToRecipeList()
//            }
    }

    func getRecipeDetails(id: Int) -> Observable<DtoRecipeInfo> {
        let getRecipeDetailsRequest = Endpoints.GetRecipeInfoRequest(id: id)
        return apiClient
            .sendAsObservable(getRecipeDetailsRequest)
//            .map{$0.mapToRecipe()}
    }
}

//
//  HomeRouter.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 01/01/21.
//

import Foundation
import UIKit

protocol HomeRouterProtocol {
    func toDetailView(for recipe: Recipe)
}

class DummyHomeRouter : HomeRouterProtocol {
    func toDetailView(for recipe: Recipe) {
        print("to Detail View")
    }
}

//class HomeRouter {
////    private let storyBoard: UIStoryboard
////    private let navigationController: UINavigationController
////    private let services: UseCaseProvider
//
//    init(services: UseCaseProvider,
//         navigationController: UINavigationController,
//         storyBoard: UIStoryboard) {
//        self.services = services
//        self.navigationController = navigationController
//        self.storyBoard = storyBoard
//    }
//}
//
//extension HomeRouter : HomeRouterProtocol {
//    func toDetailView(for recipe: Recipe)  {
//        return RecipeDetailsViewController()
//        //    let detailUseCase = Injection.init().provideDetail(category: category)
//        //    let presenter = DetailPresenter(detailUseCase: detailUseCase)
//        //    return DetailView(presenter: presenter)
//    }
//}

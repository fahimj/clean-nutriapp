//
//  HomeRouter.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 01/01/21.
//

import Foundation
import UIKit
import SwinjectStoryboard

protocol HomeRouterProtocol {
    func toDetailView(for recipe: Recipe)
}

class DummyHomeRouter : HomeRouterProtocol {
    func toDetailView(for recipe: Recipe) {
        print("to Detail View")
    }
}

class HomeRouter {}

extension HomeRouter : HomeRouterProtocol {
    func toDetailView(for recipe: Recipe)  {
        let homeVc = SwinjectStoryboard.defaultContainer.resolve(HomeViewController.self)
        let presenter = SwinjectStoryboard.defaultContainer.resolve(RecipeDetailsPresenter.self,argument: recipe)
        let storyboard = SwinjectStoryboard.create(name: "Main", bundle: nil, container: SwinjectStoryboard.defaultContainer)
        let vc = storyboard.instantiateViewController(withIdentifier: "RecipeDetails") as! RecipeDetailsViewController
        
        vc.presenter = presenter
        
        homeVc?.navigationController?.pushViewController(vc, animated: true)

    }
}

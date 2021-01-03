//
//  FavoriteRouter.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 02/01/21.
//

import Foundation
import UIKit
import SwinjectStoryboard

protocol FavoriteRouterProtocol {
    func toDetailView(for recipe: Recipe)
}

class DummyFavoriteRouter : HomeRouterProtocol {
    func toDetailView(for recipe: Recipe) {
        print("to Detail View")
    }
}

class FavoriteRouter {}

extension FavoriteRouter : FavoriteRouterProtocol {
    func toDetailView(for recipe: Recipe)  {
        let homeVc = SwinjectStoryboard.defaultContainer.resolve(FavoriteViewController.self)
        let presenter = SwinjectStoryboard.defaultContainer.resolve(RecipeDetailsPresenter.self,argument: recipe)
        let storyboard = SwinjectStoryboard.create(name: "Main", bundle: nil, container: SwinjectStoryboard.defaultContainer)
        let vc = storyboard.instantiateViewController(withIdentifier: "RecipeDetails") as! RecipeDetailsViewController

        vc.presenter = presenter

        homeVc?.navigationController?.pushViewController(vc, animated: true)

    }
}

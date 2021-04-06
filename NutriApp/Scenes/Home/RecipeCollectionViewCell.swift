//
//  RecipeCollectionViewCell.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 02/01/21.
//

import UIKit
import AlamofireImage

class RecipeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func bindData(recipe: Recipe) {
        titleLabel.text = recipe.title
        if let urlString = recipe.image, let url = URL.init(string: urlString) {
            self.recipeImageView.af.setImage(withURL: url)
        }
    }
}

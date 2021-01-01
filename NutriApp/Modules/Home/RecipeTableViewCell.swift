//
//  RecipeTableViewCell.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 01/01/21.
//

import UIKit
import AlamofireImage

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(recipe: Recipe) {
        titleLabel.text = recipe.title
        if let urlString = recipe.image, let url = URL.init(string: urlString) {
            self.recipeImageView.af.setImage(withURL: url)
        }
    }

}

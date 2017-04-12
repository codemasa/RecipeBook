//
//  IngredientCell.swift
//  RecipeBook
//
//  Created by Cody Abe on 3/21/17.
//  Copyright © 2017 Cody Abe. All rights reserved.
//

import UIKit

class IngredientCell: UITableViewCell {
    
    func update(for ingredient: String?) {
        if (ingredient != "None Added"){
            ingredientLabel.text = ingredient
            
        }
    }
    
    @IBOutlet private weak var ingredientLabel: UILabel!
    
    
}

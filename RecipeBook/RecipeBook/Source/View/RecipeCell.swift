//
//  RecipeCell.swift
//  RecipeBook
//
//  Created by Cody Abe on 2/28/17.
//  Copyright © 2017 Cody Abe. All rights reserved.
//

import UIKit

class RecipeCell : UITableViewCell {
        
    func update(for step: String, instruction: String) {
        instructionLabel.text = instruction
        stepLabel.text = "Instructions:"
    }
    
    @IBOutlet private weak var stepLabel: UILabel!
    @IBOutlet private weak var instructionLabel: UILabel!
}

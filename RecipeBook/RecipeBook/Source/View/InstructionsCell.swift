//
//  InstructionsCell.swift
//  RecipeBook
//
//  Created by Cody Abe on 3/17/17.
//  Copyright © 2017 Cody Abe. All rights reserved.
//

import UIKit

class InstructionCell: UITableViewCell {
    
    func update(for instructionType: String?) {
        if (instructionType != "None Added"){
            instructionTypeLabel.text = instructionType
            
        }
    }
    
    @IBOutlet private weak var instructionTypeLabel: UILabel!
    
    
}

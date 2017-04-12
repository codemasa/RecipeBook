//
//  InputCell.swift
//  RecipeBook
//
//  Created by Cody Abe on 3/17/17.
//  Copyright © 2017 Cody Abe. All rights reserved.
//

import UIKit

class InputCell: UITableViewCell {
    
    func update(for inputType: String?, inputAmount: String?) {
        if (inputType != "None Added"){
            inputTypeLabel.text = inputType
            inputAmountLabel.text = inputAmount
            
        }
    }
    
    @IBOutlet private weak var inputTypeLabel: UILabel!
    @IBOutlet private weak var inputAmountLabel: UILabel!

    
}

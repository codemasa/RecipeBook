//
//  NameCell.swift
//  RecipeBook
//
//  Created by Cody Abe on 3/17/17.
//  Copyright © 2017 Cody Abe. All rights reserved.
//

import UIKit


class NameCell: UITableViewCell{
    
    func update(for name: String?) {
        if (name != "None Added"){
            nameLabel.text = name
            
            
        }
    }

    @IBOutlet private weak var nameLabel: UILabel!
    

}

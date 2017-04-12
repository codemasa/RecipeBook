//
//  AddPictureCell.swift
//  RecipeBook
//
//  Created by Cody Abe on 3/17/17.
//  Copyright © 2017 Cody Abe. All rights reserved.
//

import UIKit

class AddPictureCell: UITableViewCell {
    
    func update(for image: Picture?) {
        if let addImage = image{
            addPhotoImageView.image = UIImage(data: addImage.picture as! Data, scale: 1.0)
        }
    }
    
    @IBOutlet private weak var addPhotoImageView: UIImageView!
    
}

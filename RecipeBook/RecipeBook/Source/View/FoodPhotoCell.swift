//
//  FoodPhotoImageCell.swift
//  RecipeBook
//
//  Created by Cody Abe on 3/10/17.
//  Copyright © 2017 Cody Abe. All rights reserved.
//

import UIKit

class FoodPhotoCell: UICollectionViewCell {
    
    func update(for picture: Picture?) {
        if let addImage = picture{
            foodPhotoImageView.image = UIImage(data: addImage.picture as! Data, scale: 1.0)
        }
    }
    
    @IBOutlet private weak var foodPhotoImageView: UIImageView!

}

//
//  PhotosViewController.swift
//  RecipeBook
//
//  Created by Cody Abe on 2/28/17.
//  Copyright © 2017 Cody Abe. All rights reserved.
//

import UIKit
import CoreData

class PhotosViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, NSFetchedResultsControllerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pictureFetchedResultsController = RecipeService.shared.recipePhotos(for: recipe)
        pictureFetchedResultsController.delegate = self
        foodPhotosCollectionView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        foodPhotosCollectionView.reloadData()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        foodPhotosCollectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodPhotoCell", for: indexPath) as! FoodPhotoCell
        let picture = pictureFetchedResultsController.object(at: indexPath)
        cell.update(for: picture)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictureFetchedResultsController.sections?.first?.numberOfObjects ?? 0
    }
    
    //MARK: IBOutlet
    @IBOutlet private weak var foodPhotosCollectionView: UICollectionView!
    
    //MARK: Properties (Private)
    private var pictureFetchedResultsController: NSFetchedResultsController<Picture>!
    
    //MARK: Properties
    var recipe : Recipe! = nil

}

//
//  IngredientsVeiwController.swift
//  RecipeBook
//
//  Created by Cody Abe on 2/28/17.
//  Copyright © 2017 Cody Abe. All rights reserved.
//

import UIKit
import CoreData

class IngredientsViewController : UIViewController, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientsTableView.rowHeight = UITableViewAutomaticDimension
        ingredientsTableView.estimatedRowHeight = 44
        
        ingredientsFetchedResultsController = RecipeService.shared.recipeIngredients(for: recipe)
        ingredientsFetchedResultsController.delegate = self
        ingredientsTableView.reloadData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        ingredientsTableView.reloadData()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        ingredientsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingredientsTableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as! IngredientCell
        let ingredient = ingredientsFetchedResultsController.object(at: indexPath)
        cell.update(for: ingredient.ingredient)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsFetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    
    
    
    
    //MARK: IBOutlet
    @IBOutlet private weak var ingredientsTableView: UITableView!
    
    
    //MARK: Properties (Private)
    private var ingredientsFetchedResultsController: NSFetchedResultsController<Ingredient>!

    //MARK: Properties
    var recipe : Recipe! = nil
    
}

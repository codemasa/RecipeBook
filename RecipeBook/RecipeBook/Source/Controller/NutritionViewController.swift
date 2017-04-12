//
//  NutritionViewController.swift
//  RecipeBook
//
//  Created by Cody Abe on 2/28/17.
//  Copyright © 2017 Cody Abe. All rights reserved.
//

import UIKit
import CoreData

class NutritionViewController : UIViewController, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nutritionFactFetchedResultsController = RecipeService.shared.recipeNutrition(for: recipe)
        nutritionFactFetchedResultsController.delegate = self
        nutritionTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = nutritionTableView.dequeueReusableCell(withIdentifier: "NutrientCell", for: indexPath)
        let nutrition = nutritionFactFetchedResultsController.object(at: indexPath)
        
        cell.textLabel?.text = nutrition.nutritionFact
        cell.detailTextLabel?.text = "\(nutrition.amountOf!) grams"
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nutritionFactFetchedResultsController.sections?.first?.numberOfObjects ?? 0
    }
    
    
    
    
    
    //MARK: IBOutlet
    @IBOutlet private weak var nutritionTableView: UITableView!
    
    //MARK: Properties (Private)
    private var nutritionFactFetchedResultsController: NSFetchedResultsController<NutritionFact>!
    
    //MARK: Properties
    var recipe : Recipe! = nil

}

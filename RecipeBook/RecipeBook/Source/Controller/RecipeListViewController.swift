//
//  ViewController.swift
//  RecipeBook
//
//  Created by Cody Abe on 2/27/17.
//  Copyright © 2017 Cody Abe. All rights reserved.
//

import UIKit
import CoreData

class RecipeListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, CreateViewControllerDelegate{

    //MARK:Delegate Functions for CreateViewController
    func cancelCreate(_ createViewController: CreateViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func saveCreate(_ createViewController: CreateViewController) {
        dismiss(animated: true, completion: nil)
    }
    

    // MARK: NSFetchedResultsController
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        // For more dynamic applications it is more appropriate to implement the other delegate methods
        // to do more fine-grained updates.  In simple cases this can be appropriate.
        recipeTableView.reloadData()
    }

    
    //MARK: Table View Set Up
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipeTableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        let type = indexPath.section
        let recipe = recipeNamesFetchedResultsController.sections?[type].objects?[indexPath.row] as! Recipe
        cell.textLabel?.text = recipe.recipeName
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeNamesFetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return recipeNamesFetchedResultsController.sections?.count ?? 0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return recipeNamesFetchedResultsController.sections![section].name
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove Recipe"
    }
    //MARK: View controls
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        observerTokens.append(NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: OperationQueue.main, using: { [unowned self] (notification) in
            self.recipeTableView.adjustInsets(forWillShowKeyboardNotification: notification)
        }))
        
        observerTokens.append(NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: OperationQueue.main, using: { [unowned self] (notification) in
            self.recipeTableView.adjustInsets(forWillHideKeyboardNotification: notification)
        }))
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        for observerToken in observerTokens {
            NotificationCenter.default.removeObserver(observerToken)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeNamesFetchedResultsController = RecipeService.shared.recipeName()
        recipeNamesFetchedResultsController.delegate = self
        recipeTableView.reloadData()
    }
    
    //MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "CreateSegue"){
            let createViewController = segue.destination.childViewControllers[0] as! CreateViewController
            createViewController.delegate = self
        }
        if(segue.identifier == "RecipeSegue"){
            let recipeDetailViewController = segue.destination as! RecipeDetailViewController
            let selectedIndexPath = recipeTableView.indexPathForSelectedRow!
            let recipe = recipeNamesFetchedResultsController.object(at: selectedIndexPath)
            recipeDetailViewController.recipe = recipe
            recipeDetailViewController.title = recipe.recipeName
            recipeTableView.deselectRow(at: selectedIndexPath, animated: true)

        }
        else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBarText = searchBar.text
    }
    //MARK: Private
    private var observerTokens = Array<Any>()
    private var recipeNamesFetchedResultsController: NSFetchedResultsController<Recipe>!
    private var searchBarText: String! = nil
    
    //MARK: IBOutlets
    @IBOutlet private weak var recipeTableView : UITableView!
}


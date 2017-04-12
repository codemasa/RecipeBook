//
//  RecipeDetailViewController.swift
//  RecipeBook
//
//  Created by Cody Abe on 2/28/17.
//  Copyright © 2017 Cody Abe. All rights reserved.
//

import UIKit
import CoreData
import EventKit

class RecipeDetailViewController : UIViewController, CreateViewControllerDelegate, DateAddViewControllerDelegate, UINavigationControllerDelegate{
    //MARK: View Controls
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientsView.isHidden = false
    
    }
    override func viewDidAppear(_ animated: Bool) {
        ingredientsView.isHidden = false
    }
    //MARK: CreateViewControllerDelegate
    func cancelCreate(_ createViewController: CreateViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func saveCreate(_ createViewController: CreateViewController) {
        dismiss(animated: true, completion: nil)
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK: DateAddViewControllerDelegate
    func didSubmitDate(_ dateAddViewController: DateAddViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: IBAction
    @IBAction func segmentSwitcher(for sender: UISegmentedControl){
        let segmentControl = sender
        let segmentNumber = segmentControl.selectedSegmentIndex

        
        if (segmentNumber == 0){
            ingredientsView.isHidden = false
            recipeView.isHidden = true
            nutritionView.isHidden = true
            photosView.isHidden = true
            
        }
        if (segmentNumber == 1){
            ingredientsView.isHidden = true
            recipeView.isHidden = false
            nutritionView.isHidden = true
            photosView.isHidden = true

        }
        if (segmentNumber == 2){
            ingredientsView.isHidden = true
            recipeView.isHidden = true
            nutritionView.isHidden = false
            photosView.isHidden = true
        }
        if (segmentNumber == 3){
            ingredientsView.isHidden = true
            recipeView.isHidden = true
            nutritionView.isHidden = true
            photosView.isHidden = false
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "IngredientsSegue"){
            let ingredientsViewController = segue.destination as! IngredientsViewController
            ingredientsViewController.recipe = recipe
        }
        if (segue.identifier == "NutritionSegue"){
            let nutritionViewController = segue.destination as! NutritionViewController
            nutritionViewController.recipe = recipe
        }
        if (segue.identifier == "InstructionsSegue"){
            let instructionsController = segue.destination as! RecipeViewController
            instructionsController.recipe = recipe
        }
        if (segue.identifier == "PhotosSegue"){
            let photosController = segue.destination as! PhotosViewController
            photosController.recipe = recipe
        }
        if (segue.identifier == "RecipeEditSegue"){
            let createViewController = segue.destination.childViewControllers[0] as! CreateViewController
            createViewController.recipe = recipe
            createViewController.delegate = self
            createViewController.title = "Edit Recipe"
            createViewController.name = recipe.recipeName
            createViewController.type = recipe.recipeType
            createViewController.nutrient = RecipeService.shared.recipeNutrition(for: recipe).fetchedObjects
            createViewController.instruction = RecipeService.shared.recipeInstructions(for: recipe).fetchedObjects
            createViewController.ingredient = RecipeService.shared.recipeIngredients(for: recipe).fetchedObjects
        }
        if (segue.identifier == "DateAddSegue"){
            let dateAddViewController = segue.destination as! DateAddViewController
            dateAddViewController.recipe = recipe
            dateAddViewController.delegate = self
        }
        else{
            super.prepare(for: segue, sender: sender)
        }
    }
    
    
    //MARK: IBOutlet
    @IBOutlet private weak var ingredientsView: UIView!
    @IBOutlet private weak var recipeView: UIView!
    @IBOutlet private weak var nutritionView: UIView!
    @IBOutlet private weak var photosView: UIView!

    //MARK: Properties
    var recipe : Recipe! = nil
    


}

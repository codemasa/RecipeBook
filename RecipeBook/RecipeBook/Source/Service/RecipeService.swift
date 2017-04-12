//
//  RecipeService.swift
//  RecipeBook
//
//  Created by Cody Abe on 2/28/17.
//  Copyright © 2017 Cody Abe. All rights reserved.
//

import CoreData
import UIKit

class RecipeService {
    //MARK: Service
    func recipeName() -> NSFetchedResultsController<Recipe> {
        let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        
        
        fetchRequest.sortDescriptors = [ NSSortDescriptor(key: "recipeType", ascending: false), NSSortDescriptor(key: "recipeName", ascending: false)]
        
        return createRecipeFetchedResultsController(for: fetchRequest)
        
    }

    func recipeIngredients(for recipe: Recipe) -> NSFetchedResultsController<Ingredient>{
        
        let fetchRequest: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        fetchRequest.predicate =  NSPredicate(format: "recipe == %@", recipe)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "ingredient", ascending: false)]
        
        return createFetchedResultsController(for: fetchRequest)

        
    }
    func recipeInstructions(for recipe: Recipe) -> NSFetchedResultsController<Instruction>{
        let fetchRequest: NSFetchRequest<Instruction> = Instruction.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "recipe == %@", recipe)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "instructionStep", ascending: true)]

        
        return createFetchedResultsController(for: fetchRequest)

        
        
    }
    func recipeNutrition(for recipe: Recipe) -> NSFetchedResultsController<NutritionFact>{
        let fetchRequest: NSFetchRequest<NutritionFact> = NutritionFact.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "recipe == %@", recipe)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "nutritionFact", ascending: false)]

        return createFetchedResultsController(for: fetchRequest)

        
    }
    
    func recipePhotos(for recipe: Recipe) -> NSFetchedResultsController<Picture>{
        let fetchRequest: NSFetchRequest<Picture> = Picture.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "recipe == %@", recipe)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "picture", ascending: false)]
        
        return createFetchedResultsController(for: fetchRequest)

        
    }
    
    func addRecipe(withName name: String, ingredients: String?, steps: String?, carbs: String?, protein: String?, fat: String?, and picture: UIImage?, with recipeType: String) throws{
        
        let context = persistentContainer.viewContext
        let recipe = Recipe(context: context)
        if let someIngredientSet = ingredients {
            let ingredientSet = Ingredient(context: context)
            ingredientSet.ingredient = someIngredientSet
            recipe.addToIngredient(ingredientSet)
        }
        if let someInstructionSet = steps {
            let instructionSet = Instruction(context: context)
            instructionSet.instructionStep = someInstructionSet
            recipe.addToInstructionStep(instructionSet)
            
        }
        if let someAddedCarbs = carbs{
            let addedCarbs = NutritionFact(context: context)
            addedCarbs.amountOf = someAddedCarbs
            addedCarbs.nutritionFact = "Carbohydrate"
            recipe.addToMacroNutrients(addedCarbs)
        }
        if let someAddedProtein = protein{
            let addedProtein = NutritionFact(context: context)
            addedProtein.amountOf = someAddedProtein
            addedProtein.nutritionFact = "Protein"
            recipe.addToMacroNutrients(addedProtein)
        }
        if let someAddedFat = fat{
            let addedFat = NutritionFact(context: context)
            addedFat.amountOf = someAddedFat
            addedFat.nutritionFact = "Fat"
            recipe.addToMacroNutrients(addedFat)
        }
        if let somePicture = picture, let somePictureData = UIImageJPEGRepresentation(somePicture, 1.0) {
            let pictureEntity = Picture(context: context)
            pictureEntity.picture = somePictureData as NSData
            pictureEntity.recipe = recipe
        }
        recipe.recipeName = name
        recipe.recipeType = recipeType
        try context.save()
        
    }
    
    func edit(recipe: Recipe, withName name: String, ingredients: String?, steps: String?, carbs: String?, protein: String?, fat: String?, and picture: UIImage?, with recipeType: String) throws{
        let context = persistentContainer.viewContext
        if let ingredientsExist = recipe.ingredient{
            for items in ingredientsExist{
                let toDelete = ingredientsExist.member(items) as! Ingredient
                context.delete(toDelete)
            }
        }
        if let instructionsExist = recipe.instructionStep{
            for items in instructionsExist{
                let toDelete = instructionsExist.member(items) as! Instruction
                context.delete(toDelete)
            }
        }
        if let nutritionExists = recipe.macroNutrients{
            for items in nutritionExists{
                let toDelete = nutritionExists.member(items) as! NutritionFact
                context.delete(toDelete)
            }
            recipe.removeFromMacroNutrients(nutritionExists)
        }
        if let pictureExists = recipe.mediaSlide{
            for items in pictureExists{
                let toDelete = pictureExists.member(items) as! Picture
                context.delete(toDelete)
            }
        }
        if let someIngredientSet = ingredients {
            let ingredientSet = Ingredient(context: context)
            ingredientSet.ingredient = someIngredientSet
            recipe.addToIngredient(ingredientSet)
        }
        if let someInstructionSet = steps {
            let instructionSet = Instruction(context: context)
            instructionSet.instructionStep = someInstructionSet
            recipe.addToInstructionStep(instructionSet)
            
        }
        if let someAddedCarbs = carbs{
            let addedCarbs = NutritionFact(context: context)
            addedCarbs.amountOf = someAddedCarbs
            addedCarbs.nutritionFact = "Carbohydrate"
            recipe.addToMacroNutrients(addedCarbs)
        }
        if let someAddedProtein = protein{
            let addedProtein = NutritionFact(context: context)
            addedProtein.amountOf = someAddedProtein
            addedProtein.nutritionFact = "Protein"
            recipe.addToMacroNutrients(addedProtein)
        }
        if let someAddedFat = fat{
            let addedFat = NutritionFact(context: context)
            addedFat.amountOf = someAddedFat
            addedFat.nutritionFact = "Fat"
            recipe.addToMacroNutrients(addedFat)
        }
        if let somePicture = picture, let somePictureData = UIImageJPEGRepresentation(somePicture, 1.0) {
            let pictureEntity = Picture(context: context)
            pictureEntity.picture = somePictureData as NSData
            pictureEntity.recipe = recipe
        }
        recipe.recipeName = name
        recipe.recipeType = recipeType
        try context.save()
        
    }

    
    
    //MARK: Private
    func createRecipeFetchedResultsController<T>(for fetchRequest: NSFetchRequest<T>) -> NSFetchedResultsController<T>{
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: "recipeType", cacheName: nil)
        do{
            try fetchedResultsController.performFetch()
        }
        catch let error {
            fatalError("Could not perform fetch for fetched results controller \(error)")
        }
        return fetchedResultsController
    }
    func createFetchedResultsController<T>(for fetchRequest: NSFetchRequest<T>) -> NSFetchedResultsController<T>{
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        do{
            try fetchedResultsController.performFetch()
        }
        catch let error {
            fatalError("Could not perform fetch for fetched results controller \(error)")
        }
        return fetchedResultsController
    }
    
    //MARK: Initialization
    private init() {
        persistentContainer = NSPersistentContainer(name: "RecipeBook")
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
        //Intentionally left blank
        })
    }
    
    
    
    //MARK: Private
    private let persistentContainer: NSPersistentContainer
    
    //MARK: Properties (static)
    static let shared = RecipeService()
}

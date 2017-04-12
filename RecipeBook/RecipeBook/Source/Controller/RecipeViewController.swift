//
//  RecipeViewController.swift
//  RecipeBook
//
//  Created by Cody Abe on 2/28/17.
//  Copyright © 2017 Cody Abe. All rights reserved.
//

import UIKit
import CoreData

class RecipeViewController : UIViewController, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instructionsTableView.rowHeight = UITableViewAutomaticDimension
        instructionsTableView.estimatedRowHeight = 44
        
        instructionsFetchedResultsController = RecipeService.shared.recipeInstructions(for: recipe)
        instructionsFetchedResultsController.delegate = self
        instructionsTableView.reloadData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        instructionsTableView.reloadData()

    }
    override func viewDidAppear(_ animated: Bool) {
        instructionsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = instructionsTableView.dequeueReusableCell(withIdentifier: "InstructionCell", for: indexPath) as! RecipeCell

        let instructions = instructionsFetchedResultsController.object(at: indexPath)
        
       
        let stepNum = instructions.stepIndex
        if let step = instructions.instructionStep{
            cell.update(for: "Step \(stepNum)", instruction: step)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return instructionsFetchedResultsController.sections?.first?.numberOfObjects ?? 0
    }
    
    
    
    
    
    //MARK: IBOutlet
    @IBOutlet private weak var instructionsTableView: UITableView!
    
    
    //MARK: Properties (Private)
    private var instructionsFetchedResultsController: NSFetchedResultsController<Instruction>!

    //MARK: Properties
    var recipe : Recipe! = nil

}

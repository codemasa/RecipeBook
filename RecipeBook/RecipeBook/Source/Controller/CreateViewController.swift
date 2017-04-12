 //
//  CreateViewController.swift
//  RecipeBook
//
//  Created by Cody Abe on 2/28/17.
//  Copyright © 2017 Cody Abe. All rights reserved.
//

import UIKit
import MobileCoreServices
import UserNotifications

class CreateViewController : UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: TableView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextBox.placeholder = "Enter Name Here"
        typeTextBox.placeholder = "Type of Protein"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        nameTextBox.text = name
        typeTextBox.text = type
        if let macros = nutrient{
            for item in macros{
                if item.nutritionFact == "Carbohydrate"{
                    carbTextBox.text = item.amountOf
                }
                if item.nutritionFact == "Protein"{
                    proteinTextBox.text = item.amountOf
                }
                if item.nutritionFact == "Fat"{
                fatTextBox.text = item.amountOf
                }
            }
        }
        if let steps = instruction{
            for step in steps{
                instructionTextBox.text = step.instructionStep
            }
        }
        if let parts = ingredient{
            for stuff in parts{
                ingredientTextBox.text = stuff.ingredient
            }
        }

        
        updateUIForPicture(animated: false)
    }
    
    
    //MARK: IBAction
    @IBAction func cancelPressed(sender: AnyObject) {
        if delegate != nil {
            delegate!.cancelCreate(self)
        }
    }
    @IBAction func savePressed(sender: AnyObject) {
        if (nameTextBox.text != "" && typeTextBox.text != ""){
            do{
                if let someRecipe = recipe{
                    try RecipeService.shared.edit(recipe: someRecipe, withName: nameTextBox.text!, ingredients: ingredientTextBox.text, steps: instructionTextBox.text, carbs: carbTextBox.text, protein: proteinTextBox.text, fat: fatTextBox.text, and:  pictureBox.image, with: typeTextBox.text!)

                    
                    delegate.saveCreate(self)

                    
                }
                else{
                    try RecipeService.shared.addRecipe(withName: nameTextBox.text!, ingredients: ingredientTextBox.text, steps: instructionTextBox.text, carbs: carbTextBox.text, protein: proteinTextBox.text, fat: fatTextBox.text, and: pictureBox.image, with: typeTextBox.text!)
                    delegate.saveCreate(self)

                }

                
            }
            catch _ {
                

                if let someRecipe = recipe{
                    let alertController = UIAlertController(title: "Edit failed", message: "Failed to edit the recipe \(someRecipe.recipeName!)", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alertController, animated: true, completion: nil)
                }
                else{
                    let alertController = UIAlertController(title: "Save failed", message: "Failed to save the new recipe!", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alertController, animated: true, completion: nil)
                }
                
            }
        }
        else {
            let alertController = UIAlertController(title: "Name and Type required", message: "Please enter a name and type of protein.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
        
            
        
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch createTableRow.rows[indexPath.row]{
        case .name:
            nameTextBox.becomeFirstResponder()
        case .carb:
            carbTextBox.becomeFirstResponder()
        case .protein:
            proteinTextBox.becomeFirstResponder()
        case .fat:
            fatTextBox.becomeFirstResponder()
        case .instruction:
            instructionTextBox.becomeFirstResponder()
        case .ingredient:
            ingredientTextBox.becomeFirstResponder()
        case .picture:
            if picture == nil{
                let alertController = UIAlertController(title: nil, message: "Pick Image Source", preferredStyle: .actionSheet)
                
                let checkSourceType = { (sourceType: UIImagePickerControllerSourceType, buttonText: String) -> Void in
                    if UIImagePickerController.isSourceTypeAvailable(sourceType) {
                        alertController.addAction(UIAlertAction(title: buttonText, style: .default, handler: self.imagePickerControllerSourceTypeActionHandler(for: sourceType)))
                    }
                }
                checkSourceType(.camera, "Camera")
                checkSourceType(.photoLibrary, "Photo Library")
                checkSourceType(.savedPhotosAlbum, "Saved Photos Album")
                
                if !alertController.actions.isEmpty {
                    alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    
                    present(alertController, animated: true, completion: nil)
                }
            
            }
        }
    }
    
    //MARK: Image Picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // First check for an edited image, then the original image
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            picture = image
        }
        else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            picture = image
        }
        
        updateUIForPicture()
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    private func imagePickerControllerSourceTypeActionHandler(for sourceType: UIImagePickerControllerSourceType) -> (_ action: UIAlertAction) -> Void {
        return { (action) in
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            imagePickerController.mediaTypes = [kUTTypeImage as String] // Import the MobileCoreServices framework to use kUTTypeImage (see top of file)
            imagePickerController.allowsEditing = true
            
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    

    //MARK: Private
    private func updateUIForPicture(animated: Bool = true) {
        if animated {
            if let somePicture = picture, pictureBox.isHidden {
                pictureBox.image = somePicture
                self.pictureBox.transform = CGAffineTransform(scaleX: 0.01, y: 0.01).rotated(by: CGFloat(-M_PI))
                pictureBox.isHidden = false
                clearImage.alpha = 0.0
                clearImage.isHidden = false
                
                UIView.animate(withDuration: 0.2, animations: { () -> Void in
                    self.pictureBox.transform = CGAffineTransform.identity
                    self.clearImage.alpha = 1.0
                    self.imageLabel.alpha = 0.0
                }, completion: { (complete) -> Void in
                    self.imageLabel.alpha = 1.0
                    self.imageLabel.isHidden = true
                })
            }
            else {
                imageLabel.alpha = 0.0
                imageLabel.isHidden = false
                
                UIView.animate(withDuration: 0.2, animations: { () -> Void in
                    self.pictureBox.transform = CGAffineTransform(scaleX: 0.01, y: 0.01).rotated(by: CGFloat(M_PI))
                    self.clearImage.alpha = 0.0
                    self.imageLabel.alpha = 1.0
                }, completion: { (complete) -> Void in
                    self.pictureBox.image = nil
                    self.pictureBox.transform = CGAffineTransform.identity
                    self.pictureBox.isHidden = true
                    self.clearImage.alpha = 1.0
                    self.clearImage.isHidden = false
                })
            }
        }
    }
        
    //MARK: Delegate
    weak var delegate: CreateViewControllerDelegate!
    
    //MARK: IBOutlet
    @IBOutlet private weak var cancelButton: UIBarButtonItem!
    @IBOutlet private weak var SaveButton: UIBarButtonItem!
    @IBOutlet private weak var nameTextBox: UITextField!
    @IBOutlet private weak var typeTextBox: UITextField!
    @IBOutlet private weak var carbTextBox: UITextField!
    @IBOutlet private weak var proteinTextBox: UITextField!
    @IBOutlet private weak var fatTextBox: UITextField!
    @IBOutlet private weak var instructionTextBox: UITextView!
    @IBOutlet private weak var ingredientTextBox: UITextView!
    @IBOutlet private weak var pictureBox: UIImageView!
    @IBOutlet private weak var clearImage: UIButton!
    @IBOutlet private weak var imageLabel: UILabel!


    //MARK: IBAction
    @IBAction private func clearPicture(_ sender: AnyObject) {
        self.view.endEditing(true)
        
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to delete the picture?", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Delete Picture", style: .destructive, handler: { (action: UIAlertAction) -> Void in
            self.picture = nil
            
            self.updateUIForPicture()
        }))
        
        present(alertController, animated: true, completion: nil)
    }

    
    //MARK: Properties

    var picture: UIImage? = nil
    var name: String? = nil
    var type: String? = nil
    var nutrient: [NutritionFact]? = nil
    var instruction: [Instruction]? = nil
    var ingredient: [Ingredient]? = nil
    var recipe: Recipe! = nil

    

    
    
    //Table Row Enum
    private enum createTableRow{
        case name
        case carb
        case protein
        case fat
        case instruction
        case ingredient
        case picture
        
        static let rows: Array<createTableRow> = [.name, .carb, .protein, .fat, .instruction, .ingredient, .picture]
    }
    
}


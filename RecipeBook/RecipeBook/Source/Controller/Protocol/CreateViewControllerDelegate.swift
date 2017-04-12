//
//  CreateRecipeDelegate.swift
//  RecipeBook
//
//  Created by Cody Abe on 3/21/17.
//  Copyright © 2017 Cody Abe. All rights reserved.
//

protocol CreateViewControllerDelegate: class {
    func cancelCreate(_ createViewController: CreateViewController)
    func saveCreate(_ createViewController: CreateViewController)
}

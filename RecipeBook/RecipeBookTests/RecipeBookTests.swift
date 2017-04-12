//
//  RecipeBookTests.swift
//  RecipeBookTests
//
//  Created by Cody Abe on 2/27/17.
//  Copyright © 2017 Cody Abe. All rights reserved.
//

import UIKit
import XCTest
@testable import RecipeBook

class RecipeBookTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testRecipesLoad(){
        let recipes = recipeService.recipeName().sections?.count
        XCTAssertNotNil(recipes)
        
    }
    func testInstructionsLoad(){
        let recipe = recipeService.recipeName().fetchedObjects
        for data in recipe!{
            let instructions = recipeService.recipeInstructions(for: data).sections?.count
            XCTAssertNotNil(instructions)
        }
    }
    func testNutrientsLoad(){
        let recipe = recipeService.recipeName().fetchedObjects
        for data in recipe!{
            let nutrition = recipeService.recipeNutrition(for: data).sections?.count
            XCTAssertNotNil(nutrition)
        }
    }
    func testPicturesLoad(){
        let recipe = recipeService.recipeName().fetchedObjects
        for data in recipe!{
            let photo = recipeService.recipePhotos(for: data).sections?.count
            XCTAssertNotNil(photo)
        }
    }
    
    
    
    
    let recipeService = RecipeService.shared
}

//
//  RecipeBookUITests.swift
//  RecipeBookUITests
//
//  Created by Cody Abe on 2/27/17.
//  Copyright © 2017 Cody Abe. All rights reserved.
//

import XCTest

class RecipeBookUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

    func testRecipeListViewController(){
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.cells.staticTexts["This"].tap()
        app.navigationBars["This"].buttons["Recipe Book"].tap()
        
        let addButton = app.navigationBars["Recipe Book"].buttons["Add"]
        addButton.tap()
        
        let titleNavigationBar = app.navigationBars["TItle"]
        titleNavigationBar.buttons["Cancel"].tap()
        addButton.tap()
        
        let saveButton = titleNavigationBar.buttons["Save"]
        saveButton.tap()
        app.alerts["Name and Type required"].buttons["OK"].tap()
        
        XCTAssertNotNil(tablesQuery.cells.allElementsBoundByIndex)

        
    }
    
    func testSegmentedViewControllers(){
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.cells.staticTexts["This"].tap()
        tablesQuery.cells.staticTexts["Graded"].tap()
        app.segmentedControls.buttons["Instructions"].tap()
        tablesQuery.cells.staticTexts["Instructions:"].tap()
        app.segmentedControls.buttons["Nutrition Facts"].tap()
        app.segmentedControls.buttons["Photos"].tap()
        let editButton = app.navigationBars["This"].buttons["Edit"]
        editButton.tap()
        let editRecipeNavigationBar = app.navigationBars["Edit Recipe"]
        editRecipeNavigationBar.buttons["Cancel"].tap()
        editButton.tap()
        editRecipeNavigationBar.buttons["Save"].tap()
        
        XCTAssertNotNil(tablesQuery.allElementsBoundByIndex)
        
        
    }
    
    func testCalendarAdder(){
        
        let app = XCUIApplication()
        app.tables.cells.staticTexts["This"].tap()
        
        let thisNavigationBar = app.navigationBars["This"]
        thisNavigationBar.buttons["Share"].tap()
        
        let datePickersQuery = app.datePickers
        let todayPickerWheel = datePickersQuery.pickerWheels["Today"]
        todayPickerWheel.tap()
        app.buttons["Add to Calendar"].tap()
        thisNavigationBar.buttons["Recipe Book"].tap()
        XCTAssertNotNil(datePickersQuery)
    }
    
}

//
//  FocusOnUITests.swift
//  FocusOnUITests
//
//  Created by Alexandra Ivanova on 23/12/2021.
//

import XCTest
@testable import FocusOn

class FocusOnUITests: XCTestCase {

    private let app = XCUIApplication()
    
    override func setUpWithError() throws {

        continueAfterFailure = false

        app.launchArguments += ["UITesting"]
        app.launch()
        
        let firstScreenTitle = app.staticTexts["Today"]
        let exists = firstScreenTitle.waitForExistence(timeout: 10)
        XCTAssert(exists, "First screen title doen't exist after 10 seconds.")
    }

    override func tearDownWithError() throws {
        
    }

    func test_FocusOn_UITest_AddGoal() throws {
//        XCUIApplication().alerts["“FocusOn” Would Like to Send You Notifications"].scrollViews.otherElements.buttons["Allow"].tap()
        
        // Elements
        let myGoalTextField = app.textFields["MyAddGoalTextField"]
        let addGoalButton = app.buttons["AddGoalButton"]
        
        // Given
        XCTAssert(app.staticTexts["WHAT IS YOUR GOAL FOR TODAY?"].exists)
        XCTAssert(myGoalTextField.exists)
        XCTAssert(addGoalButton.exists)
        
        // WHen
        myGoalTextField.tap()
        myGoalTextField.typeText("Test goal text field")
        XCTAssertEqual(myGoalTextField.value as! String, "Test goal text field", "Text field value is not correct")

        addGoalButton.tap()
        
        // Then
        XCTAssert(app.staticTexts["WHAT ARE THE THREE TASKS TO ACHIEVE IT?"].exists)
    }
    
    func test_FocusOn_UITest_AddTAsksToGoal() throws {
        // Elements
        let myGoalTextField = app.textFields["MyUpdateGoalTextField"]
        let myFirstTaskTextField = app.textFields["myTaskTextField0"]
        let mySecondTaskTextField = app.textFields["myTaskTextField1"]
        let myThirdTaskTextField = app.textFields["myTaskTextField2"]
        
        // Given
        XCTAssert(app.staticTexts["WHAT IS YOUR GOAL FOR TODAY?"].exists)
        XCTAssert(app.staticTexts["WHAT ARE THE THREE TASKS TO ACHIEVE IT?"].exists)
        XCTAssertEqual(myGoalTextField.value as! String, "Test goal text field", "Text field value is not correct")
        XCTAssert(myFirstTaskTextField.exists)
        XCTAssert(mySecondTaskTextField.exists)
        XCTAssert(myThirdTaskTextField.exists)
        
        // WHen
        myFirstTaskTextField.tap()
        myFirstTaskTextField.typeText("Test first task\n")
        XCTAssertEqual(myFirstTaskTextField.value as! String, "Test first task", "Text field value is not correct")
        
        sleep(1)
        
        mySecondTaskTextField.tap()
        mySecondTaskTextField.typeText("Test second task\n")
        XCTAssertEqual(mySecondTaskTextField.value as! String, "Test second task", "Text field value is not correct")
        
        sleep(1)
        
        myThirdTaskTextField.tap()
        myThirdTaskTextField.typeText("Test third task\n")
        XCTAssertEqual(myThirdTaskTextField.value as! String, "Test third task", "Text field value is not correct")
        
        sleep(1)
        
        XCUIApplication().tabBars["Tab Bar"].buttons["History"].tap()
        
        // Then
        XCTAssert(app.staticTexts["Test goal text field"].exists)
        XCTAssert(app.staticTexts["Test first task"].exists)
        XCTAssert(app.staticTexts["Test second task"].exists)
        XCTAssert(app.staticTexts["Test second task"].exists)
    }
    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

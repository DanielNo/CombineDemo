//
//  CombineDemoUITests.swift
//  CombineDemoUITests
//
//  Created by Daniel No on 7/13/21.
//

import XCTest
@testable import CombineDemo

extension XCTestCase {
    
    func wait(forElement element: XCUIElement, timeout: TimeInterval) {
        let predicate = NSPredicate(format: "exists == 1")
        expectation(for: predicate, evaluatedWith: element)
        waitForExpectations(timeout: timeout)
    }

}


class CombineDemoUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        app.launch()
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSubmitButtonState_validCredentials(){
        let enabled = testSubmitButtonWithCredentials("longenoughuser@gmail.com", "$ecurePaSSword!")
        XCTAssert(enabled, "submit button should be enabled with valid credentials")
    }
    
    func testSubmitButtonState_invalidCredentials(){
        let enabled = testSubmitButtonWithCredentials(".", "2")
        XCTAssertEqual(enabled, false,"submit button should be enabled with a password that is too short to pass validation")
    }
    
    func testSubmitButtonState_shortPassword(){
        let enabled = testSubmitButtonWithCredentials("Mr.appuser@gmail.com", "1234")
        XCTAssertEqual(enabled, false,"submit button should be disabled with a password that is too short to pass validation")
    }
    
    func testSubmitButtonWithCredentials(_ username : String, _ password : String) -> Bool{
        let userTextfieldElement = app.textFields[TestingIdentifiers.ReactiveViewController.userTextField.rawValue]
        wait(forElement: userTextfieldElement, timeout: 5)
                
        userTextfieldElement.tap()
        userTextfieldElement.typeText(username)
        let passTextfield = app.textFields[TestingIdentifiers.ReactiveViewController.passTextfield.rawValue]
        wait(forElement: userTextfieldElement, timeout: 5)
        passTextfield.tap()
        passTextfield.typeText(password)
        
        let submitBtn = app.buttons[TestingIdentifiers.ReactiveViewController.submitBtn.rawValue]
        wait(forElement: userTextfieldElement, timeout: 5)
        return submitBtn.isEnabled
    }

}

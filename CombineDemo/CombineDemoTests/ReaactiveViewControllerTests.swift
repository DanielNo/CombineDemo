//
//  ReaactiveViewControllerTests.swift
//  CombineDemoTests
//
//  Created by Daniel No on 7/21/21.
//

import XCTest
@testable import CombineDemo

class ReaactiveViewControllerTests: XCTestCase {
    let sut = ReactiveViewController()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let textfield = UITextField(frame: .zero)
        
        sut.sendTextToTextField(textfield, "usernameeeee")

        let exp = XCTestExpectation(description: "testing combine")
        exp.expectedFulfillmentCount = 2
        
        self.inputUsername("test ")
        
        waitForExpectations(timeout: 30) { err in
            print(err)
        }
    }
    
    func inputUsername(_ str : String){
        sut.usernameTextField.text = str
        sut.usernameTextField.sendActions(for: .valueChanged)
        sut.usernameTextField.sendActions(for: .editingChanged)
        let text = sut.usernameTextField.text
        print(text)
    }
    
    func inputPassword(_ str : String){
        
    }

}

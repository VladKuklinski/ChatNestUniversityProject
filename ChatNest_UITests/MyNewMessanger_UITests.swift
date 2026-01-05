//
//  MyNewMessanger_UITests.swift
//  MyNewMessanger_UITests
//
//  Created by Vlad Kuklinski on 19/09/2025.
//

import XCTest

final class MyNewMessanger_UITests: XCTestCase {
    
    
    
    @MainActor
    func test_logingInAndLogingOut_Success() throws {
        let app = XCUIApplication()
        app.activate()
        
        app/*@START_MENU_TOKEN@*/.textFields["Write email"]/*[[".otherElements.textFields[\"Write email\"]",".textFields",".textFields[\"Write email\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        app/*@START_MENU_TOKEN@*/.textFields["Write email"]/*[[".otherElements",".textFields[\"List@gmail.com\"]",".textFields[\"Write email\"]",".textFields"],[[[-1,2],[-1,1],[-1,3],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.firstMatch.typeText("List@gmail.com")
        
        let element = app/*@START_MENU_TOKEN@*/.secureTextFields["Write password"]/*[[".otherElements.secureTextFields[\"Write password\"]",".secureTextFields",".secureTextFields[\"Write password\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch
        element.tap()
        element.tap()
        app/*@START_MENU_TOKEN@*/.secureTextFields["Write password"]/*[[".otherElements",".secureTextFields[\"••••••\"]",".secureTextFields[\"Write password\"]",".secureTextFields"],[[[-1,2],[-1,1],[-1,3],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.firstMatch.typeText("121212")
        app/*@START_MENU_TOKEN@*/.buttons["Login"]/*[[".otherElements.buttons[\"Login\"]",".buttons[\"Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        
        app/*@START_MENU_TOKEN@*/.images["myImageID"]/*[[".otherElements[\"myImageID-myImageID\"].images",".buttons.images[\"myImageID\"]",".images[\"myImageID\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        
        let element2 = app/*@START_MENU_TOKEN@*/.buttons["Log out"]/*[[".otherElements.buttons[\"Log out\"]",".buttons[\"Log out\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch
        element2.tap()
        element2.tap()
    }
    
    func test_changingNameAndLogingOut() throws {
        let app = XCUIApplication()
        app.activate()
//        app/*@START_MENU_TOKEN@*/.images["myImageID"]/*[[".otherElements[\"myImageID-myImageID\"].images",".buttons.images[\"myImageID\"]",".images[\"myImageID\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
//
//        
//        let element = app/*@START_MENU_TOKEN@*/.buttons["Log out"]/*[[".otherElements.buttons[\"Log out\"]",".buttons[\"Log out\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch
//        element.tap()
//        element.tap()
//        app/*@START_MENU_TOKEN@*/.textFields["Write email"]/*[[".otherElements.textFields[\"Write email\"]",".textFields",".textFields[\"Write email\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
//        app/*@START_MENU_TOKEN@*/.textFields["Write email"]/*[[".otherElements",".textFields[\"List@gmail.com\"]",".textFields[\"Write email\"]",".textFields"],[[[-1,2],[-1,1],[-1,3],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.firstMatch.typeText("list@gmail.com")
//        
//        let element2 = app/*@START_MENU_TOKEN@*/.secureTextFields["Write password"]/*[[".otherElements.secureTextFields[\"Write password\"]",".secureTextFields",".secureTextFields[\"Write password\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch
//        element2.tap()
//        element2.tap()
//        app/*@START_MENU_TOKEN@*/.secureTextFields["Write password"]/*[[".otherElements",".secureTextFields[\"••••••\"]",".secureTextFields[\"Write password\"]",".secureTextFields"],[[[-1,2],[-1,1],[-1,3],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.firstMatch.typeText("121212")
//        app/*@START_MENU_TOKEN@*/.buttons["Login"]/*[[".otherElements.buttons[\"Login\"]",".buttons[\"Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        app/*@START_MENU_TOKEN@*/.images["myImageID"]/*[[".otherElements[\"myImageID-myImageID\"].images",".buttons.images[\"myImageID\"]",".images[\"myImageID\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        let element = app/*@START_MENU_TOKEN@*/.buttons["Log out"]/*[[".otherElements.buttons[\"Log out\"]",".buttons[\"Log out\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch

        element.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Cancel"]/*[[".otherElements.buttons[\"Cancel\"]",".buttons[\"Cancel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Edit data"]/*[[".otherElements[\"Edit data\"].buttons",".otherElements.buttons[\"Edit data\"]",".buttons[\"Edit data\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        
        let element3 = app.textFields["Listujik"].firstMatch
        element3.tap()
        element3.tap()
        app.textFields["Listujik"].firstMatch.typeText("ik")
        app/*@START_MENU_TOKEN@*/.buttons["Save data"]/*[[".otherElements[\"Save data\"].buttons",".otherElements.buttons[\"Save data\"]",".buttons[\"Save data\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        app.windows.element(boundBy: 1).tap()
        element.tap()
        element.tap()
        
    }
}





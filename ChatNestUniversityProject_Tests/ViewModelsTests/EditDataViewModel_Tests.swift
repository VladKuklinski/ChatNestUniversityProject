//
//  EditDataViewModel_Tests.swift
//  MyNewMessangerTests
//
//  Created by Vlad Kuklinski on 17/09/2025.
//

import XCTest
@testable import MyNewMessanger

final class EditDataViewModel_Tests: XCTestCase {

    func test_changeName_success() async throws {
        let newName = "Dima"
        
        let userService = MockUserService()
        let firestoreService = MockFirestoreService_success()
        let authService = MockAuthServiceSuccess()
        let viewModel = EditDataViewModel(userService: userService,
                                          firestoreService: firestoreService,
                                          authService: authService)
        //
        try await viewModel.changeName(newName: newName)
        //
        XCTAssertEqual(firestoreService.currentUserUid, userService.currentUser?.uid)
        XCTAssertEqual(firestoreService.newUserName, newName)
        
    }
    
    func test_changeName_failure() async throws {
        let newName = "Dima"
        
        let userService = MockUserService()
        let firestoreService = MockFirestoreService_failure()
        let authService = MockAuthServiceFailure()
        let viewModel = EditDataViewModel(userService: userService,
                                          firestoreService: firestoreService,
                                          authService: authService)
        //
        try await viewModel.changeName(newName: newName)
        //
        XCTAssertNil(firestoreService.currentUserUid)
        XCTAssertEqual(viewModel.message, "Failed to change a name: Failed change user name")
        
    }
    
    func test_changeEmail_success() async throws {
        let newEmail = "x@gmail.com"
        let userService = MockUserService()
        let authService = MockAuthServiceSuccess()
        let viewModel = EditDataViewModel(userService: userService, authService: authService)
        
        try await viewModel.changeEmail(to: newEmail)
        
        XCTAssertTrue(viewModel.sentWithSuccess)
        XCTAssertEqual(viewModel.message, "A reset link was sent to new email: \(newEmail)")
    }
    
    func test_changeEmail_failure() async throws {
        let newEmail = "x@gmail.com"
        let userService = MockUserService()
        let authService = MockAuthServiceFailure()
        let viewModel = EditDataViewModel(userService: userService, authService: authService)
        
        try await viewModel.changeEmail(to: newEmail)
        
        XCTAssertFalse(viewModel.sentWithSuccess)
        XCTAssertEqual(viewModel.message, "Failed to send a link: Failed to change an email")
    }

}

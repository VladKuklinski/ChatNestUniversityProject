
//  ProfileViewModel_Tests.swift
//  MyNewMessangerTests
//
//  Created by Vlad Kuklinski on 17/09/2025.




import XCTest
@testable import MyNewMessanger

final class ProfileViewModel_Tests: XCTestCase {

    func test_deleteAccount_success() async {
        let authService = MockAuthServiceSuccess()
        let userService = MockUserService()
        let viewModel = ProfileViewModel(userService: userService,
                                         authService: authService)

        //
        await viewModel.deleteAccount()
        //

        XCTAssertNil(viewModel.errorAlertMessage)
    }

    func test_deleteAccount_failure() async {
        let authService = MockAuthServiceFailure()
        let userService = MockUserService()
        let viewModel = ProfileViewModel(userService: userService,
                                         authService: authService)

        //
        await viewModel.deleteAccount()
        //

        XCTAssertEqual(viewModel.errorAlertMessage, "Failed to delete account")
    }
    
    func test_signingOut_success() async {
        let authService = MockAuthServiceSuccess()
        let userService = MockUserService()
        let viewModel = ProfileViewModel(userService: userService,
                                         authService: authService)
        
        //
        await viewModel.signOut()
        //
        XCTAssertNil(viewModel.errorAlertMessage)

    }
    
    func test_signingOut_failure() async {
        let authService = MockAuthServiceFailure()
        let userService = MockUserService()
        let viewModel = ProfileViewModel(userService: userService,
                                         authService: authService)
        //
        await viewModel.signOut()
        //
        XCTAssertEqual(viewModel.errorAlertMessage, "Failed to sign out")

    }
}

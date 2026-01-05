//
//  RegistrationViewModel_Tests.swift
//  MyNewMessangerTests
//
//  Created by Vlad Kuklinski on 17/09/2025.
//

import XCTest
@testable import MyNewMessanger

final class RegistrationViewModel_Tests: XCTestCase {

    @MainActor func test_creatingUser_success() async {
        let authService = MockAuthServiceSuccess()
        let viewModel = RegistrationViewModel(authService: authService)
        viewModel.profileImage = nil
        viewModel.email = "test@gmail.com"
        viewModel.fullName = "Vlad"
        viewModel.password = "121212"
        //
        await viewModel.signIn()
        //
        XCTAssertNil(viewModel.errorMessage)
    }
    
    @MainActor func test_creatingUser_failure() async {
        let authService = MockAuthServiceFailure()
        let viewModel = RegistrationViewModel(authService: authService)
        viewModel.profileImage = nil
        viewModel.email = "test@gmail.com"
        viewModel.fullName = "Vlad"
        viewModel.password = "121212"
        //
        await viewModel.signIn()
        //
        XCTAssertEqual(viewModel.errorMessage, "Failed to create a user")
        
    }
}

//
//  InboxViewModel_Tests.swift
//  MyNewMessangerTests
//
//  Created by Vlad Kuklinski on 16/09/2025.
//

import XCTest
@testable import MyNewMessanger
import Combine

final class InboxViewModel_Tests: XCTestCase {
    
    func test_loadRecentMessages_loadedSuccessfully() {
        
        let observingService = MockObservingMessagesService()
        let userService = MockUserService()
        observingService.recentMessagesToSend = [mockMessage1, mockMessage2]
        
        //
        let viewModel = InboxViewModel(observingMessagesService: observingService,
                                       userService: userService)
        //
        XCTAssertEqual(viewModel.recentMessages.count, 2)
        XCTAssertEqual(viewModel.recentMessages[0].messageText, "Hi there")
        XCTAssertEqual(viewModel.recentMessages[1].messageText, "Hi bombom")
        
    }
    
    func test_FilterActiveUsers_UsersFilteredCorrectly() async throws {
        let currentUid = mockUser1.uid
        let observingService = MockObservingMessagesService()
        let userService = MockUserService()
        let authService = MockFirebaseAuthService()
        
        let viewModel = InboxViewModel(observingMessagesService: observingService,
                                       userService: userService,
                                       authService: authService)
        
        try await viewModel.filterActiveUsers()
        
        //
        XCTAssertEqual(viewModel.currentUser?.uid, currentUid)

        //
        XCTAssertEqual(viewModel.users.count, 1)
        XCTAssertEqual(viewModel.users.first?.fullName, "Nonna Kulikova-Hres")
        //
    }
}

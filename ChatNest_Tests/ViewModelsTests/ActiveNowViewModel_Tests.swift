//
//  Test.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 16/09/2025.
//

import XCTest
@testable import MyNewMessanger
import SwiftUI

final class ActiveNowViewModel_Tests : XCTestCase {

    
    func test_observeUserStatus_succed()  {
        //GIVEN
        let user = mockUser1
        let mockManager = MockActivityStatusManager()
        let viewModel = ActiveNowViewModel(user: user, manager: mockManager)
        let newData = Date()
        
        //WHEN
        mockManager.sendStatus(isActive: true, lastActive: newData)
        
        //THEN
        XCTAssertTrue(viewModel.user.isActive)
        XCTAssertEqual(viewModel.user.lastActive.timeIntervalSince1970, newData.timeIntervalSince1970, accuracy: 0.1)
    }
}

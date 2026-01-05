//
//  MockActivityStatusManager.swift
//  MyNewMessangerTests
//
//  Created by Vlad Kuklinski on 16/09/2025.
//

import Foundation
@testable import MyNewMessanger


class MockActivityStatusManager : ActivityStatusManagerProtocol {
    
    var setupOnlineStatusCalledWith : String?
    var setupOfflineStatusCalledWith : String?
    var observerCompletion : ((Bool, Date) -> Void)?
    var deleteStatusCalledWith : String?
    
    func setupOnlineStatus(for uid: String) {
        setupOnlineStatusCalledWith = uid
    }
    
    func setupOfflineStatus(for uid: String) {
        setupOfflineStatusCalledWith = uid
    }
    
    func sendStatus(isActive: Bool, lastActive: Date) {
        observerCompletion?(isActive, lastActive)
    }
    
    func observeStatus(for uid: String, onUpdate: @escaping (Bool, Date) -> Void) {
        observerCompletion = onUpdate
    }
    
    func deleteStatus(for uid: String) {
        deleteStatusCalledWith = uid
    }
    
    
}

//
//  ActiveNowViewModel.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 09/09/2025.
//

import Foundation
import SwiftUI

class ActiveNowViewModel : ObservableObject {
    @Published var user : User
    private let manager : ActivityStatusManagerProtocol
    
    init(user: User, manager : ActivityStatusManagerProtocol) {
        self.user = user
        self.manager = manager
        observeUserStatus()
    }
    
    private func observeUserStatus() {
        manager.observeStatus(for: user.uid ?? "") { isActive, lastActivity in
            DispatchQueue.main.async {
                self.user.isActive = isActive
                self.user.lastActive = lastActivity
            }
        }
    }
    
    var color : Color {
        switch user.activityStatus {
        case .online:
            return .green
        case .offline:
            return .gray
        }
    }
}



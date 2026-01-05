//
//  ProfileSettingsHelper.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 01/08/2025.
//

import Foundation
import SwiftUI

enum ProfileSettings : String, CaseIterable, Identifiable {
    case darkMode, activeStatus, accessibility, privacyAndSafety, notifications
    var id : String {
        self.rawValue
    }
    var title : String {
        switch self {
        case .darkMode:
            "Dark Mode"
        case .activeStatus:
            "Active status"
        case .accessibility:
            "Accessibility"
        case .privacyAndSafety:
            "Privacy and safety"
        case .notifications:
            "Notifications"
        }
    }
    var image: String {
            switch self {
            case .darkMode: 
                return "moon.circle.fill"
            case .activeStatus:
                return "antenna.radiowaves.left.and.right.circle"
            case .accessibility:
                return "figure.walk.circle"
            case .privacyAndSafety:
                return "lock.circle.fill"
            case .notifications:
                return "bell.circle.fill"
            }
        }
    var backGroundColor : Color {
        switch self {
        case .darkMode:
                .black
        case .activeStatus:
                .green
        case .accessibility:
                .black
        case .privacyAndSafety:
                .blue
        case .notifications:
                .purple
        }
    }
}

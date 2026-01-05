//
//  userExtension.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 14/09/2025.
//

import Foundation
import FirebaseFirestore

extension User {
    static let mockUser = User(fullName: "Nonna Kulikova-Hres", email: "kulikovahres@gmail.com", imageUrl: "nonna", isActive: true, lastActive: Date(), incomingRequests: [""], outgoingRequests: [""])
}
extension Message {
    static let mockMessage = Message(toId: "mockToID", fromId: "mockFromID", messageText: "Hi there", timestamp: Timestamp(date: Date()))
}

//
//  MockUser.swift
//  MyNewMessangerTests
//
//  Created by Vlad Kuklinski on 16/09/2025.
//

import Foundation
@testable import MyNewMessanger

import FirebaseCore

let mockMessage1 = Message(toId: "mockToID",
                           fromId: "mockFromID",
                           messageText: "Hi there",
                           timestamp: Timestamp(date: Date()))

let mockMessage2 = Message(toId: "mockToID",
                           fromId: "mockFromID",
                           messageText: "Hi bombom", timestamp: Timestamp(date: Date()))

let mockUser1 = User(uid: "vlad",
                     fullName: "Vlad",
                     email: "kulikovahres@gmail.com",
                     imageUrl: "nonna",
                     isActive: true,
                     lastActive: Date())

let mockUser2 = User(uid: "nonna",
                     fullName: "Nonna Kulikova-Hres",
                     email: "kulikovahres@gmail.com",
                     imageUrl: "nonna",
                     isActive: true,
                     lastActive: Date())


//
//  User.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 01/08/2025.
//

import Foundation
import FirebaseFirestore

struct User : Codable, Identifiable, Hashable, Equatable{
    
    @DocumentID var uid : String?
    var fullName : String
    var email : String
    var imageUrl : String?
    var isActive : Bool
    var lastActive: Date
    var friends: [String] = []
    var incomingRequests: [String] = []
    var outgoingRequests: [String] = []
    var id : String {
        return uid ?? email
    }
    var activityStatus : ActivityStatus {
        if self.isActive {
            return .online
        } else {
            return .offline
        }
    }
}
enum ActivityStatus : Equatable {
    case online
    case offline
    
}




extension User {
    static func fromDictionary(_ dict: [String: Any]) -> User? {
        guard let fullName = dict["fullName"] as? String,
              let email = dict["email"] as? String,
              let isActive = dict["isActive"] as? Bool,
              let lastActiveTimestamp = dict["lastActive"] as? TimeInterval else {
            return nil
        }

        let uid = dict["uid"] as? String
        let imageUrl = dict["imageUrl"] as? String
        let friends = dict["friends"] as? [String] ?? []
        let incomingRequests = dict["incomingRequests"] as? [String] ?? []
        let outgoingRequests = dict["outgoingRequests"] as? [String] ?? []

        return User(
            uid: uid,
            fullName: fullName,
            email: email,
            imageUrl: imageUrl,
            isActive: isActive,
            lastActive: Date(timeIntervalSince1970: lastActiveTimestamp / 1000),
            friends: friends,
            incomingRequests: incomingRequests,
            outgoingRequests: outgoingRequests
        )
    }
}

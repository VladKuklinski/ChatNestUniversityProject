//
//  Message.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 04/08/2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

struct Message : Identifiable, Hashable, Codable {
    @DocumentID var messageId : String?
    var toId : String
    var fromId : String
    var messageText : String
    var timestamp : Timestamp
    var user: User?
    var id : String {
        return messageId ?? UUID().uuidString
    }
    var chatPartnerId : String {
        fromId == Auth.auth().currentUser?.uid ? toId : fromId
        }
    var fromCurrentUser : Bool {
        fromId == Auth.auth().currentUser?.uid
    }
}

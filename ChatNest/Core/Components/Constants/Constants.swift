//
//  Constants.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 04/09/2025.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

struct Constants {
    static let imageLocation = "profile_images/"
    static let deleteText = "You sure you want to permanently delete your profile?"
    static let messageColection = Firestore.firestore().collection("messages")
    static let logoutText = "You sure you want to log out?"
}

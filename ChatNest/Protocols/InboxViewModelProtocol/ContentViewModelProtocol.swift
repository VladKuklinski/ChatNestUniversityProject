//
//  InboxViewModelProtocol.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 17/09/2025.
//

import Foundation
import FirebaseAuth

protocol ContentViewModelProtocol : AnyObject {
    var currentUser : FirebaseAuth.User? {get set}
}

//
//  FirestoreServiceProtocol.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 17/09/2025.
//

import Foundation
protocol FirestoreServiceProtocol {
    func changeUserName(uid : String, newName : String) async throws
}

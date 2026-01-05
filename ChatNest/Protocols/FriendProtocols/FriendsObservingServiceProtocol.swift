//
//  FriendsObservingServiceProtocol.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 24/09/2025.
//

import Foundation

protocol FriendsObservingServiceProtocol {
    func observeFriends(for uid: String, onUpdate: @escaping ([User], [User], [User]) -> Void)
    func stopObserving()
}

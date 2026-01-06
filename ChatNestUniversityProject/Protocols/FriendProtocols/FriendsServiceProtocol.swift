//
//  FriendsObservingServiceProtocol.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 24/09/2025.
//

import Foundation

protocol FriendsServiceProtocol {
    func connect()
    func disconnect()
    var updates: AsyncStream<FriendsUpdate> {get}
}

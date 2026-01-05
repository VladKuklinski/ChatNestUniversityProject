//
//  ActivityServiceProtocol.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 15/09/2025.
//

import Foundation

protocol ActivityStatusManagerProtocol {
    func setupOnlineStatus(for uid : String)
    func setupOfflineStatus(for uid : String)
    func observeStatus(for uid: String, onUpdate: @escaping (Bool, Date) -> Void)
    func deleteStatus(for uid: String)
}

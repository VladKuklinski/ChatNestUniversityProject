//
//  ContentViewModel.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 04/08/2025.
//

import Foundation
import Combine
import FirebaseAuth

class ContentViewModel : ObservableObject, ContentViewModelProtocol {
    
    @Published var currentUser : FirebaseAuth.User?
    
    init() {
        Task {
            try await setupSubscribers()
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    private func setupSubscribers() async throws {
        await AuthService.shared.$userSession
            .receive(on: DispatchQueue.main)
            .sink { [weak self] sessionFromAuthService in
                self?.currentUser = sessionFromAuthService
            }
            .store(in: &cancellables)
    }
}

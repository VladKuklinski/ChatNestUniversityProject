//
//  RegistrationViewModel.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 04/08/2025.
//

import Foundation
import SwiftUI
import PhotosUI

@MainActor
class RegistrationViewModel : ObservableObject {
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var selectedImage : PhotosPickerItem?
    @Published var profileImage : Image?
    @Published var errorMessage : String?
    private var uiImage : UIImage?
    private let authService : AuthServiceProtocol
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    func setImage() async throws {
        guard let image = selectedImage else {return}
        guard let data = try? await image.loadTransferable(type: Data.self) else {return}
        guard let chechedUIImage = UIImage(data: data) else {return}
        self.profileImage = Image(uiImage: chechedUIImage)
        self.uiImage = chechedUIImage
    }
    func signIn() async {
        do {
            try await authService.createUser(fullName: fullName, email: email, password: password, profileImage: uiImage)
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}

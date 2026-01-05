import SwiftUI
import PhotosUI
import Firebase
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth
import Combine

class ProfileViewModel: ObservableObject {
    private var userService : UserServiceProtocol
    private let authService : AuthServiceProtocol
    @Published var showErrorAlert = false
    @Published var errorAlertMessage : String?
    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            Task { await loadImage() }
        }
    }
    private var cancellables = Set<AnyCancellable>()
    init(userService : UserServiceProtocol, authService : AuthServiceProtocol) {
        self.userService = userService
        self.authService = authService
        userService.currentUserPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] fetchedUser in
                self?.user = fetchedUser
            }
            .store(in: &cancellables)
        Task {
            if userService.currentUser == nil {
                try? await userService.fetchUserData(uid: nil)
            }
        }
    }
    @Published var user: User?
    @Published var tempImage: Image?
    private func loadImage() async {
        guard let image = selectedImage else { return }
        do {
            if let data = try await image.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                await MainActor.run {
                    self.tempImage = Image(uiImage: uiImage)
                }
                Task {
                    try await self.uploadProfileImage(uiImage)
                }
            }
        } catch {
            print("DEBUG: Failed to load image \(error.localizedDescription)")
        }
    }
    private func uploadProfileImage(_ image: UIImage) async throws {
        guard let uid = Auth.auth().currentUser?.uid,
              let data = image.jpegData(compressionQuality: 0.5) else { return }
        let ref = Storage.storage().reference(withPath: "\(Constants.imageLocation + uid).jpg")
        _ = try await ref.putDataAsync(data)
        let url = try await ref.downloadURL()
        try await Firestore.firestore().collection("users").document(uid).updateData([
            "imageUrl": url.absoluteString
        ])
        await MainActor.run {
            self.user?.imageUrl = url.absoluteString
            userService.currentUser?.imageUrl = url.absoluteString
        }
    }
    func signOut() async {
        do {
            try await authService.signOut()
        } catch {
            errorAlertMessage = error.localizedDescription
            showErrorAlert.toggle()
        }
    }
    func deleteAccount() async {
        do {
            try await authService.deleteAccount()
        } catch {
            errorAlertMessage = error.localizedDescription
            showErrorAlert.toggle()
        }
    }
}


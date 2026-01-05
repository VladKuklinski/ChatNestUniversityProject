import SwiftUI
import FacebookLogin
import FirebaseAuth
import FirebaseFirestore
import FacebookCore

@MainActor
class FacebookLoginButtonViewModel: ObservableObject{
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    let fbAuthService : FacebookAuthServiceProtocol
    private let contentViewModel: ContentViewModelProtocol
    private let authService : AuthServiceProtocol
    private let activityManager : ActivityStatusManagerProtocol
    
    init(fbAuthService: FacebookAuthServiceProtocol,
         contentViewModel : ContentViewModelProtocol,
         authService : AuthServiceProtocol,
         activityManager : ActivityStatusManagerProtocol) {
        self.fbAuthService = fbAuthService
        self.contentViewModel = contentViewModel
        self.authService = authService
        self.activityManager = activityManager
    }
    
    func login() async {
        isLoading = true
        do {
            let user = try await fbAuthService.login()
            await authService.setUserSession(user)

            contentViewModel.currentUser = user
            activityManager.setupOnlineStatus(for: user.uid)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}

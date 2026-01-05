import Foundation
import FirebaseAuth
import FirebaseDatabase

class ActivityStatusManager: ActivityStatusManagerProtocol {
    private var ref: DatabaseReference?
    func setupOnlineStatus(for uid : String) {
        ref = Database.database().reference(withPath: "status/\(uid)")
        let onlineObject: [String: Any] = [
            "isActive": true,
            "lastActive": ServerValue.timestamp()
        ]
        let offlineObject: [String: Any] = [
            "isActive": false,
            "lastActive": ServerValue.timestamp()
        ]
        ref?.onDisconnectSetValue(offlineObject)
        ref?.setValue(onlineObject)
    }
    func setupOfflineStatus(for uid : String) {
            let ref = Database.database().reference(withPath: "status/\(uid)")
            
            ref.updateChildValues([
                "isActive": false,
                "lastActive": ServerValue.timestamp()
            ])
    }
    func deleteStatus(for uid: String) {
        let ref = Database.database().reference(withPath: "status/\(uid)")
        ref.removeValue { error, _ in
            if let error = error {
                print("DEBUG: Unable to delete data from database: \(error.localizedDescription)")
            } else {
                print("DEBUG: Data from database was successfully deleted")
            }
        }
    }
    func observeStatus(for uid: String, onUpdate: @escaping (Bool, Date) -> Void) {
        ref = Database.database().reference(withPath: "status/\(uid)")
        ref?.observe(.value) { snapshot in
            if let data = snapshot.value as? [String: Any],
               let active = data["isActive"] as? Bool,
               let timestamp = data["lastActive"] as? Double {
                let lastActive = Date(timeIntervalSince1970: timestamp / 1000)
                onUpdate(active, lastActive)
            }
        }
    }
}

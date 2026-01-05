//
//  ObservingMessageService.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 24/09/2025.
//

import FirebaseFirestore
import FirebaseAuth

class ObservingMessageService: ObservingMessageServiceProtocol {
    let messageCollection = Constants.messageColection

    func observeMessages(chatPartner: User, completion: @escaping ([Message]) -> Void) {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id

        let query = messageCollection
            .document(currentUserId)
            .collection(chatPartnerId)
            .order(by: "timestamp", descending: false)

        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            var messages = changes.compactMap { try? $0.document.data(as: Message.self) }

            for (index, message) in messages.enumerated() where message.fromId != currentUserId {
                messages[index].user = chatPartner
            }

            completion(messages)
        }
    }

    func observeRecentMessages(completion: @escaping ([Message]) -> Void) {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }

        let query = messageCollection
            .document(currentUserId)
            .collection("recent-messages")
            .order(by: "timestamp", descending: true)

        query.addSnapshotListener { snapshot, _ in
            guard let documents = snapshot?.documents else { return }

            var messages = [Message]()
            let group = DispatchGroup()

            for doc in documents {
                if var message = try? doc.data(as: Message.self) {
                    let chatPartnerId = message.fromId == currentUserId ? message.toId : message.fromId
                    group.enter()
                    Firestore.firestore().collection("users").document(chatPartnerId).getDocument { snap, _ in
                        if let user = try? snap?.data(as: User.self) {
                            message.user = user
                        }
                        messages.append(message)
                        group.leave()
                    }
                }
            }

            group.notify(queue: .main) {
                completion(messages)
            }
        }
    }
}


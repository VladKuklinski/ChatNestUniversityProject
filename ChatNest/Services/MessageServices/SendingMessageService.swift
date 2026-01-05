

import FirebaseFirestore
import FirebaseAuth

class SendingMessageService: SendingMessageServiceProtocol {
    let messageCollection = Constants.messageColection

    func sendMessage(_ textMessage: String, toUser user: User) {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = user.id

        let currentUserRef = messageCollection.document(currentUserId).collection(chatPartnerId).document()
        let chatPartnerRef = messageCollection.document(chatPartnerId).collection(currentUserId)
        let messageId = currentUserRef.documentID

        let message = Message(
            messageId: messageId,
            toId: chatPartnerId,
            fromId: currentUserId,
            messageText: textMessage,
            timestamp: Timestamp()
        )

        guard let messageData = try? Firestore.Encoder().encode(message) else { return }

        currentUserRef.setData(messageData)
        chatPartnerRef.document(messageId).setData(messageData)

        messageCollection.document(currentUserId)
            .collection("recent-messages")
            .document(chatPartnerId)
            .setData(messageData)

        messageCollection.document(chatPartnerId)
            .collection("recent-messages")
            .document(currentUserId)
            .setData(messageData)
    }
}



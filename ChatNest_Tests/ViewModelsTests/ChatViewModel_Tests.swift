//
//  ChatViewModel_Tests.swift
//  MyNewMessangerTests
//
//  Created by Vlad Kuklinski on 16/09/2025.
//

import XCTest
@testable import MyNewMessanger

final class ChatViewModel_Tests: XCTestCase {
    
    
    func test_observeMessages_succed() {
        let user = mockUser1
        let message1 = mockMessage1
        let message2 = mockMessage2
        let observingMessages = MockObservingMessagesService()
        let sendingService = MockSendingMessagesService()
        observingMessages.messagesToSend = [message1, message2]
        //
        let viewModel = ChatViewModel(user: user,
                                      sendingMessageService: sendingService,
                                      observingMessageService: observingMessages)
        //
        XCTAssertEqual(viewModel.messages.count, 2)
        XCTAssertEqual(viewModel.user, user)
        XCTAssertEqual(viewModel.messages[0].messageText, "Hi there")
        XCTAssertEqual(viewModel.messages[1].messageText, "Hi bombom")

        

        
    }
    
    func test_sendMessages_succed() {
        let user = mockUser1
        let textMessage = "Hello my Bro"
        
        let sendingService = MockSendingMessagesService()
        let viewModel = ChatViewModel(user: user,
                                      sendingMessageService: sendingService,
                                      observingMessageService: MockObservingMessagesService())
        //
        viewModel.textMessage = textMessage
        viewModel.sendMessage()
        //
        XCTAssertEqual(viewModel.textMessage, textMessage)
        XCTAssertEqual(viewModel.user, user)

        
        
    }

}

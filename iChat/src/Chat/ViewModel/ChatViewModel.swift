//
//  ChaViewModel.swift
//  iChat
//
//  Created by EDSON SANTOS on 05/02/2024.
//

import Foundation

class ChatViewModel: ObservableObject {
    
    @Published var messages:[MessageModel] = [
        MessageModel(uuid: UUID().uuidString, text: "First message", isMe: false),
        MessageModel(uuid: UUID().uuidString, text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ", isMe: true),
        MessageModel(uuid: UUID().uuidString, text: "Third message", isMe: false),
        MessageModel(uuid: UUID().uuidString, text: "Other message", isMe: true),
        MessageModel(uuid: UUID().uuidString, text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua", isMe: true),
        MessageModel(uuid: UUID().uuidString, text: "Fifth message", isMe: false),
        MessageModel(uuid: UUID().uuidString, text: "Sixth message", isMe: false)
     ]
    
    @Published var text = ""
    
}

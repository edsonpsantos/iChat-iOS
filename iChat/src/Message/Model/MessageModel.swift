//
//  MessageModel.swift
//  iChat
//
//  Created by EDSON SANTOS on 05/02/2024.
//

import Foundation


struct MessageModel: Hashable{
    let uuid: String
    let text: String
    let isMe: Bool
    let timestamp: UInt
    
}

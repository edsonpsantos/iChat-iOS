//
//  MessageViewModel.swift
//  iChat
//
//  Created by EDSON SANTOS on 02/02/2024.
//

import Foundation
import FirebaseAuth

class MessageViewModel: ObservableObject {
    
    func logout() {
        try? Auth.auth().signOut()
    }
}

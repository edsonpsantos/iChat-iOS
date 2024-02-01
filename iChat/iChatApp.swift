//
//  iChatApp.swift
//  iChat
//
//  Created by Tiago Aguiar on 07/10/21.
//

import SwiftUI
import FirebaseCore

@main
struct iChatApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            SignInView()
        }
    }
}

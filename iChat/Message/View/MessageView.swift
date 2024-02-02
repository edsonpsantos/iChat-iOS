//
//  MessageView.swift
//  iChat
//
//  Created by EDSON SANTOS on 02/02/2024.
//

import SwiftUI
import Combine

struct MessageView: View {
    
    @StateObject var viewModel = MessageViewModel()
    
    var body: some View {
        Button(action: viewModel.logout, label: {
            Text("Logout")
        })
    }
}

#Preview {
    MessageView()
}

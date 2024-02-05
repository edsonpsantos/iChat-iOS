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
        
        NavigationView {
            VStack{
                Text("Hello Messages")
            }
            .toolbar {
                ToolbarItem(id: "contents", 
                            placement: ToolbarItemPlacement.navigationBarTrailing,
                            showsByDefault: true) {
                    NavigationLink("Contacts", destination: ContactsView())
                }
                ToolbarItem(id:"logout",
                            placement:ToolbarItemPlacement.navigationBarTrailing,
                            showsByDefault: true) {
                    Button(action: viewModel.logout, 
                           label: {
                        Text("Logout")
                    })
                }
            }

        }
        
        Spacer()
      
    }
}

#Preview {
    MessageView()
}

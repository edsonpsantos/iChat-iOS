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
                if viewModel.isLoading{
                    ProgressView()
                }
                List(viewModel.contacts, id: \.self){contact in
                    NavigationLink{
                        ChatView(contact: contact)
                    } label: {
                        ContactMessageRow(contact: contact)
                    }
                }
            }
            .onAppear{
                viewModel.getContacts()
            }
            .navigationTitle("Messages")
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

struct ContactMessageRow: View {
    var contact:ContactModel
    var body: some View{
        HStack{
            AsyncImage(url: URL(string: contact.profileUrl)){ image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }.frame(width: 50, height: 50)
            
            VStack(alignment: .leading){
                Text(contact.name)
                if let msg = contact.lastMessage{
                    Text(msg)
                        .lineLimit(1)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    MessageView()
}

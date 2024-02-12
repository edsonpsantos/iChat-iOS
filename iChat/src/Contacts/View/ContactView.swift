//
//  ContactView.swift
//  iChat
//
//  Created by EDSON SANTOS on 03/02/2024.
//

import SwiftUI

struct ContactView: View {
    
    @StateObject var viewModel = ContactViewModel(repo: ContactRepository())
    
    var body: some View {
        VStack{
            if viewModel.isLoading {
                ProgressView()
            }
            
            List(viewModel.contacts, id: \.self){ contact in
                NavigationLink(
                    destination: ChatView(contact: contact),
                    label: {
                        ContactRow(contact: contact)
                    })
            }
        }.onAppear{
            viewModel.getContacts()
        }
        .navigationTitle("Contacts")
    }
}

struct ContactRow: View {
    var contact: ContactModel
    
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: contact.profileUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
                
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            
            Text(contact.name)
        }
    }
}

#Preview {
    ContactView()
}

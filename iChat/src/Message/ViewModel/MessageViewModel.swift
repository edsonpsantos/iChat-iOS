//
//  MessageViewModel.swift
//  iChat
//
//  Created by EDSON SANTOS on 02/02/2024.
//

import Foundation

class MessageViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var contacts: [ContactModel]=[]
    
    
    private var handleEnabled = true
    
    private let repo: MessageRepository
    init(repo: MessageRepository){
        self.repo = repo
    }
    
    func getContacts(){
        repo.getContacts { contacts in
            if self.handleEnabled{
                self.contacts = contacts
            } else {
                print("Contact not rendering")
            }
        }
    }
    
    func handleEnabled(enable: Bool){
        self.handleEnabled = enable
    }
    
    func logout() {
        repo.logout()
    }
}

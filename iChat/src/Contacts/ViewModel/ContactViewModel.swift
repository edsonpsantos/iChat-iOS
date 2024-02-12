//
//  ContactViewModel.swift
//  iChat
//
//  Created by EDSON SANTOS on 03/02/2024.
//

import Foundation
import Combine


class ContactViewModel: ObservableObject {
    
    @Published var contacts: [ContactModel]=[]
    @Published var isLoading = false
    
    var isLoaded = false
    
    private let repo: ContactRepository
    init(repo: ContactRepository){
        self.repo = repo
    }
    
    func getContacts() {

        if isLoaded {return}
        isLoading = true
        isLoaded = true
        
        repo.getContacts { contacts in
            self.contacts.append(contentsOf: contacts)
            self.isLoading = false
        }
    }
}

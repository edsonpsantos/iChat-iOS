//
//  ContactViewModel.swift
//  iChat
//
//  Created by EDSON SANTOS on 03/02/2024.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore

class ContactsViewModel: ObservableObject {
    
    @Published var contacts: [ContactModel]=[]
    @Published var isLoading = false
    
    var isLoaded = false
    
    func getContacts() {
        if isLoaded {return}
        
        isLoading = true
        isLoaded = true
        
        Firestore.firestore().collection("users")
            .getDocuments { querySnapShot, error in
                if let error = error {
                    print("Error to fetch contacts. \(error)")
                    return
                }
                
                for document in querySnapShot!.documents {
                    if Auth.auth().currentUser?.uid != document.documentID{
                        print("ID: \(document.documentID) \(document.data())")
                        self.contacts.append(ContactModel(uuid: document.documentID,
                                                          name: document.data()["name"] as! String,
                                                          profileUrl: document.data()["profileUrl"] as! String))
                        
                    }
                }
                self.isLoading = false
            }
    }
}

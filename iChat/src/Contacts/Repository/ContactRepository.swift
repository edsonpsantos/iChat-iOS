//
//  ContactRepository.swift
//  iChat
//
//  Created by EDSON SANTOS on 12/02/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class ContactRepository{
    
    func getContacts(completion: @escaping ([ContactModel]) -> Void) {

        var contacts: [ContactModel] = []
        
        Firestore.firestore().collection("users")
            .getDocuments { querySnapShot, error in
                if let error = error {
                    print("Error to fetch contacts. \(error)")
                    return
                }
                
                for document in querySnapShot!.documents {
                    if Auth.auth().currentUser?.uid != document.documentID{
                        print("ID: \(document.documentID) \(document.data())")
                        
                        contacts.append(ContactModel(uuid: document.documentID,
                                                     name: document.data()["name"] as! String,
                                                     profileUrl: document.data()["profileUrl"] as! String))
                        
                    }
                }
                completion(contacts)
            }
    }
}

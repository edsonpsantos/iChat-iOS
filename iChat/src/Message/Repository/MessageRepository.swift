//
//  MessageRepository.swift
//  iChat
//
//  Created by EDSON SANTOS on 12/02/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class MessageRepository{
    
    func getContacts(completion: @escaping ([ContactModel])-> Void){
        var contacts: [ContactModel] = []
        let fromId = Auth.auth().currentUser!.uid
        
        Firestore.firestore().collection("last-messages")
            .document(fromId)
            .collection("contacts")
            .addSnapshotListener { snapshot, error in
                if let changes = snapshot?.documentChanges{
                    for doc in changes {
                        if doc.type == .added{
                            let document = doc.document
                            
                            contacts.append(ContactModel(uuid: document.documentID,
                                                        name: document.data()["username"] as! String,
                                                        profileUrl: document.data()["photoUrl"] as! String,
                                                         lastMessage: document.data()["lastMessage"] as? String,
                                                         timestamp: document.data()["timestamp"] as? UInt))
                        }
                    }
                }
                completion(contacts)
            }
    }
    
    func logout() {
        try? Auth.auth().signOut()
    }
}

//
//  ChaViewModel.swift
//  iChat
//
//  Created by EDSON SANTOS on 05/02/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class ChatViewModel: ObservableObject {
    
    @Published var messages:[MessageModel] = []
    @Published var text = ""
    
    var myName = ""
    var myPhoto = ""
    var limit = 20
    var inserting = false
    var newCount = 0
    
    func onAppear(contact: ContactModel){
        let fromId = Auth.auth().currentUser!.uid
        
        Firestore.firestore().collection("users")
            .document(fromId)
            .getDocument{snapshot, error in
                if let error = error {
                    print("ERROR: fetching document: \(error.localizedDescription)!")
                    return
                }
                if let document = snapshot?.data(){
                    self.myName = document["name"] as! String
                    self.myPhoto = document["profileUrl"] as! String
                }
            }
        
        Firestore.firestore().collection("conversations")
            .document(fromId)
            .collection(contact.uuid)
            .order(by: "timestamp", descending: true)
            .start(after: [self.messages.last?.timestamp ?? 9999999999999999])
            .limit(to: limit)
            .addSnapshotListener { querySnapshot, error in
                if let error = error{
                    print("ERROR: fetching documents: \(error.localizedDescription)")
                    return
                }
                if let changes = querySnapshot?.documentChanges{
                    for doc in changes{
                        if doc.type == .added {
                            let document = doc.document
                            print("Document is: \(document.documentID) \(document.data())")
                            
                            let message = MessageModel(uuid: document.documentID,
                                                       text: document.data()["text"] as! String,
                                                       isMe: fromId == document.data()["fromId"] as! String, timestamp: document.data()["timestamp"] as! UInt)
                            
                            if self.inserting {
                                self.messages.insert(message, at: 0)
                            }else {
                                self.messages.append(message)
                            }
                        }
                    }
                    self.inserting = false
                }
                self.newCount = self.messages.count
            }
    }
    
    func sendMessage(contact: ContactModel){
        let text = self.text
        self.text = ""
        
        inserting = true
        newCount = newCount + 1
        
        let fromId = Auth.auth().currentUser!.uid
        let timestamp = Date().timeIntervalSince1970
        
        Firestore.firestore().collection("conversations")
            .document(fromId)
            .collection(contact.uuid)
            .addDocument(data: [
                "text": text,
                "fromId": fromId,
                "toId": contact.uuid,
                "timestamp": UInt(timestamp)
            ]){ error in
                if error != nil{
                    print("ERROR: \(String(describing: error!.localizedDescription))")
                    return
                }
                
                Firestore.firestore().collection("last-messages")
                    .document(fromId)
                    .collection("contacts")
                    .document(contact.uuid)
                    .setData([
                        "uuid": contact.uuid,
                        "username": contact.name,
                        "photoUrl": contact.profileUrl,
                        "timestamp": UInt(timestamp),
                        "lastMessage": self.text
                    ])
            }
        
        
        Firestore.firestore().collection("conversations")
            .document(contact.uuid)
            .collection(fromId)
            .addDocument(data: [
                "text": text,
                "fromId": fromId,
                "toId": contact.uuid,
                "timestamp": UInt(timestamp)
            ]){ error in
                if error != nil{
                    print("ERROR: \(String(describing: error?.localizedDescription))")
                    return
                }
                
                Firestore.firestore().collection("last-messages")
                    .document(contact.uuid)
                    .collection("contacts")
                    .document(fromId)
                    .setData([
                        "uuid": fromId,
                        "username": self.myName,
                        "photoUrl": self.myPhoto,
                        "timestamp": UInt(timestamp),
                        "lastMessage": self.text
                    ])
            }
    }
    
}

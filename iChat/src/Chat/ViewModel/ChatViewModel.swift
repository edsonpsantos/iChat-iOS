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
    
    func onAppear(toId: String){
        let fromId = Auth.auth().currentUser!.uid
        
        Firestore.firestore().collection("conversations")
            .document(fromId)
            .collection(toId)
            .order(by: "timestamp", descending: false)
            .addSnapshotListener { querySnapshot, error in
                if let error = error{
                    print("ERROR: fetching documents: \(error.localizedDescription)")
                    return
                }
                if let changes = querySnapshot?.documentChanges{
                    for doc in changes{
                        let document = doc.document
                        print("Document is: \(document.documentID) \(document.data())")
                        
                        let message = MessageModel(uuid: document.documentID, 
                                                   text: document.data()["text"] as! String,
                                                   isMe: fromId == document.data()["fromId"] as! String)
                        
                        self.messages.append(message)
                    }
                }
            }
    }
    
    func sendMessage(toId: String){
        let fromId = Auth.auth().currentUser!.uid
        let timestamp = Date().timeIntervalSince1970
        
        Firestore.firestore().collection("conversations")
            .document(fromId)
            .collection(toId)
            .addDocument(data: [
                "text": text,
                "fromId": fromId,
                "toId": toId,
                "timestamp": UInt(timestamp)
            ]){ error in
                if error != nil{
                    print("ERROR: \(String(describing: error!.localizedDescription))")
                    return
                }
            }
        
        
        Firestore.firestore().collection("conversations")
            .document(toId)
            .collection(fromId)
            .addDocument(data: [
                "text": text,
                "fromId": fromId,
                "toId": toId,
                "timestamp": UInt(timestamp)
            ]){ error in
                if error != nil{
                    print("ERROR: \(String(describing: error?.localizedDescription))")
                    return
                }
            }
    }
    
}

//
//  SignUpRepository.swift
//  iChat
//
//  Created by EDSON SANTOS on 12/02/2024.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class SignUpRepository {
    
    func signUp(withEmail email: String, 
                password: String,
                image: UIImage,
                name: String,
                completion: @escaping(String?)-> Void) {
                
        Auth.auth().createUser(withEmail: email, password: password) {
            result, err in
            guard let user = result?.user, err == nil else {
                completion(err!.localizedDescription)
                return
            }
            print("User created \(user.uid)")
            
            self.uploadPhoto(image: image, name: name){ err in
                if let err = err {
                    completion(err)
                }
            }
        }
    }
    
    private func uploadPhoto(image: UIImage, name: String, completion: @escaping (String?)->Void) {
        let filename = UUID().uuidString
        
        guard let data = image.jpegData(compressionQuality: 0.2) else {return }
        
        let newMetadata = StorageMetadata()
        newMetadata.contentType = "image/jpeg"
        
        let ref = Storage.storage().reference(withPath: "/images/\(filename).jpg")
        
        ref.putData(data, metadata: newMetadata){ metadata, err in
            ref.downloadURL{url, error in
                print("Photo Created \(String(describing: url))")
                guard let url = url else {return}
                self.createUser(photoUrl: url, name: name, completion: completion)
            }
        }
    }
    
    private func createUser(photoUrl: URL, name: String, completion: @escaping (String?)->Void){
        let id = Auth.auth().currentUser!.uid
        
        Firestore.firestore().collection("users")
            .document(id)
            .setData([
                "name": name,
                "uuid": id,
                "profileUrl": photoUrl.absoluteString
            ]) { err in
                                
                if let err = err {
                    print("Error: \(err.localizedDescription)")
                    completion(err.localizedDescription)
                    return
                }
            }
    }
}

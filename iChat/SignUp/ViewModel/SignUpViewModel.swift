//
//  SignUpViewModel.swift
//  iChat
//
//  Created by EDSON SANTOS on 29/01/2024.
//

import Foundation
import FirebaseAuth
import FirebaseStorage

class SignUpViewModel: ObservableObject{
    
    var name: String = ""
    var email: String = ""
    var password: String = ""
    
    @Published var image = UIImage()

    @Published var formInvalid = false
    var alertText = ""
    
    @Published var isLoading = false
    
    
    func signUp() {
        
        print("name: \(name), email: \(email), senha: \(password)")
        
        if (image.size.width <= 0){
            formInvalid = true
            alertText = "Select a photo"
            return
        }
        self.isLoading = true
        
        Auth.auth().createUser(withEmail: email, password: password) {
            result, err in
            guard let user = result?.user, err == nil else {
                self.formInvalid = true
                self.alertText = err!.localizedDescription
                print(err)
                self.isLoading = false
                return
            }
            self.isLoading = false
            print("User created \(user.uid)")
            
            self.uploadPhoto()
        }
    }
    
    private func uploadPhoto() {
        let filename = UUID().uuidString
        
        guard let data = image.jpegData(compressionQuality: 0.2) else {return }
        
        let newMetadata = StorageMetadata()
        newMetadata.contentType = "image/jpeg"
        
        let ref = Storage.storage().reference(withPath: "/images/\(filename).jpg")
        
        ref.putData(data, metadata: newMetadata){ metadata, err in
            ref.downloadURL{url, error in
                self.isLoading = false
                print("Photo Created \(url)")
            }
        }
    }
    
}

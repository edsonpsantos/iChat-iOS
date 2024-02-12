//
//  SignUpViewModel.swift
//  iChat
//
//  Created by EDSON SANTOS on 29/01/2024.
//

import Foundation
import FirebaseAuth


class SignUpViewModel: ObservableObject{
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""

    @Published var image = UIImage()

    @Published var formInvalid = false
    var alertText = ""
    
    @Published var isLoading = false
    
    private let repo: SignUpRepository
    init(repo: SignUpRepository){
        self.repo = repo
    }
    
    
    func signUp() {
        
        print("name: \(name), email: \(email), senha: \(password)")
        
        if (image.size.width <= 0){
            formInvalid = true
            alertText = "Select a photo"
            return
        }
        self.isLoading = true
        
        repo.signUp(withEmail: email, password: password, image: image, name: name) { err in
            if let err = err {
                self.formInvalid = true
                self.alertText = err
                print(err as Any)
            }
            self.isLoading = false
        }
    }
}

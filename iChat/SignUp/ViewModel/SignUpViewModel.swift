//
//  SignUpViewModel.swift
//  iChat
//
//  Created by EDSON SANTOS on 29/01/2024.
//

import Foundation
import FirebaseAuth

class SignUpViewModel: ObservableObject{
    
    var name: String = ""
    var email: String = ""
    var password: String = ""
    
    @Published var formInvalid = false
    var alertText = ""
    
    @Published var isLoading = false
    
    
    func signUp() {
        self.isLoading = true
        print("name: \(name), email: \(email), senha: \(password)")
        
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
        }
    }
    
}

//
//  SignInViewModel.swift
//  iChat
//
//  Created by EDSON SANTOS on 29/01/2024.
//

import Foundation
import FirebaseAuth

class SignInViewModel: ObservableObject{
    
    @Published var email: String = ""
    @Published var password: String = ""
   
    @Published var formInvalid = false
    var alertText = ""
    
    @Published var isLoading = false
    
    func signIn() {
        self.isLoading = true
        print("email: \(email), senha: \(password)")
        Auth.auth().signIn(withEmail: email, password: password){
            result, err in
            guard let user = result?.user, err == nil else {
                self.formInvalid = true
                self.alertText = err!.localizedDescription
                
                self.isLoading = false
                return
            }
            self.isLoading = false
            print("User Logged \(user.uid)")
        }
    }
    
}

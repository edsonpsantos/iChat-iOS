//
//  SignInViewModel.swift
//  iChat
//
//  Created by EDSON SANTOS on 29/01/2024.
//

import Foundation

class SignInViewModel: ObservableObject{
    
   var email: String = ""
   var password: String = ""
    
    
    func signIn() {
        print("email: \(email), senha: \(password)")
    }
    
}

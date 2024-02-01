//
//  SignUpViewModel.swift
//  iChat
//
//  Created by EDSON SANTOS on 29/01/2024.
//

import Foundation

class SignUpViewModel: ObservableObject{
    
   var name: String = ""
   var email: String = ""
   var password: String = ""
    
    
    func signUp() {
        print("name: \(name), email: \(email), senha: \(password)")
    }
    
}

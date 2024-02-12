//
//  SignInViewModel.swift
//  iChat
//
//  Created by EDSON SANTOS on 29/01/2024.
//

import Foundation


class SignInViewModel: ObservableObject{
    
    @Published var email: String = ""
    @Published var password: String = ""
   
    @Published var formInvalid = false
    var alertText = ""
    
    @Published var isLoading = false
    
    private let repo: SignInRepository
    init(repo: SignInRepository){
        self.repo = repo
    }
    
    func signIn() {
        print("email: \(email), senha: \(password)")
        
        self.isLoading = true
        
        repo.signIn(withEmail: email, password: password) { err in
            if let err = err{
                self.formInvalid = true
                self.alertText = err
                return
            }
        }
        self.isLoading = false
    }
}

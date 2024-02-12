//
//  SignInRepository.swift
//  iChat
//
//  Created by EDSON SANTOS on 12/02/2024.
//

import Foundation
import FirebaseAuth

class SignInRepository{
    
    func signIn(withEmail email: String, password: String, completion: @escaping (String?)-> Void){
        
        Auth.auth().signIn(withEmail: email, password: password){
            result, err in
            guard let user = result?.user, err == nil else {
                print("Error: \(err!)")
                completion(err!.localizedDescription)
                return
            }
            print("User Logged \(user.uid)")
            completion(nil)
        }
    }
}

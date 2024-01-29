//
//  ContentView.swift
//  iChat
//
//  Created by Tiago Aguiar on 07/10/21.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject var viewModel = SignInViewModel()
    
    var body: some View {
        VStack {
            Image("chat_logo")
                .resizable()
                .scaledToFit()
                .padding()

            TextField("Inform your email address", text: $viewModel.email)
                .padding()
                .border(Color(UIColor.separator))
            
            SecureField("Inform your password", text: $viewModel.password)
                .padding()
                .border(Color(UIColor.separator))
            
            Button(action: {
                viewModel.signIn()
            }, label: {
                Text("Sign In")
            })
            
            Divider()
            
            Button(action: {
                print("Clicked II")
            }, label: {
                Text("Don't have an account? Click here!")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

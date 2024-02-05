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
        NavigationView {
            VStack {
                Image("chat_logo")
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                TextField("Inform your email address", text: $viewModel.email)
                    .modifier(FieldStyle(
                        autoCapitalization: .none,
                        autoCorretion: true,
                        paddingOption: .bottom,
                        paddingSize: 20,
                        cornerRadiusSize: 24.0,
                        lineWidthSize: 2.0))
                
                SecureField("Inform your password", text: $viewModel.password)
                    .modifier(FieldStyle(
                        autoCapitalization: .none,
                        autoCorretion: true,
                        paddingOption: .bottom,
                        paddingSize: 30,
                        cornerRadiusSize: 24.0,
                        lineWidthSize: 2.0))
                
                if viewModel.isLoading{
                    ProgressView()
                        .padding()
                }
                
                Button(action: {
                    viewModel.signIn()
                }, label: {
                    Text("Sign In")
                        .modifier(ButtonStyle(cornerRadiusSize: 24.0,
                                              backgroundColor: "MainColor"))
                })
                
                .alert(isPresented: $viewModel.formInvalid){
                    Alert(title: Text(viewModel.alertText))
                }
                
                Divider()
                    .padding()
                
                NavigationLink(destination: SignUpView(),
                               label: {
                    Text("Don't have an account? Click here!")
                        .foregroundColor(.black)
                })
            }
            .modifier(StackStyle(
                paddingSize: 32,
                backgroundColorRed: 162,
                backgroundColorGreen: 172,
                backgroundColorBlue:189))
            .navigationTitle("Login")
            .navigationBarHidden(true)

        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

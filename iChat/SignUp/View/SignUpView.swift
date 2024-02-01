//
//  SignUpView.swift
//  iChat
//
//  Created by EDSON SANTOS on 01/02/2024.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var viewModel = SignUpViewModel()
    
    var body: some View {
        VStack {
            Image("chat_logo")
                .resizable()
                .scaledToFit()
                .padding()

            TextField("Inform your name", text: $viewModel.name)
                .modifier(FieldStyle(autoCapitalization: .words, autoCorretion: true, paddingOption: .bottom, paddingSize: 20, cornerRadiusSize: 24.0, lineWidthSize: 2.0))
            
            
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
            
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            }
            
            Button(action: {
                viewModel.signUp()
            }, label: {
                Text("Save")
                    .modifier(ButtonStyle(cornerRadiusSize: 24.0, 
                                          backgroundColor: "GreenColor"))
                  
            })
            .alert(isPresented: $viewModel.formInvalid) {
                Alert(title: Text(viewModel.alertText))
            }
            
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity, maxHeight: .infinity/*@END_MENU_TOKEN@*/)
        .padding(.horizontal, 32)
        .background(Color.init(red:240 / 255 , green: 231/255, blue: 210 / 255))
        .navigationBarTitleDisplayMode(.inline)
        .foregroundColor(.black)
        .ignoresSafeArea()
    }
}

#Preview {
    SignUpView()
}

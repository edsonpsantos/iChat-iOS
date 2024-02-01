//
//  SignUpView.swift
//  iChat
//
//  Created by EDSON SANTOS on 29/01/2024.
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
                .autocapitalization(.words)
                .autocorrectionDisabled()
                .padding()
                .background(Color.white)
                .cornerRadius(24.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 24.0)
                        .strokeBorder(Color(UIColor.separator), style: StrokeStyle(lineWidth: 2.0))
                )
                .padding(.bottom, 20)
            
            
            TextField("Inform your email address", text: $viewModel.email)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .autocorrectionDisabled()
                .padding()
                .background(Color.white)
                .cornerRadius(24.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 24.0)
                        .strokeBorder(Color(UIColor.separator), style: StrokeStyle(lineWidth: 2.0))
                )
                .padding(.bottom, 20)
            
            
            SecureField("Inform your password", text: $viewModel.password)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .autocorrectionDisabled()
                .padding()
                .background(Color.white)
                .cornerRadius(24.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 24.0)
                        .strokeBorder(Color(UIColor.separator), style: StrokeStyle(lineWidth: 2.0))
                )
                .padding(.bottom, 30)
            
            Button(action: {
                viewModel.signUp()
            }, label: {
                Text("Save")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("GreenColor"))
                    .foregroundColor(.white)
                    .cornerRadius(24.0)
            })
            
            Divider()
                .padding()
            
            Button(action: {
                print("Clicked II")
            }, label: {
                Text("Do you have an account? Sign In Here!")
                    .foregroundColor(.black)
            })
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity, maxHeight: .infinity/*@END_MENU_TOKEN@*/)
        .padding(.horizontal, 32)
        .background(Color.init(red:240 / 255 , green: 231/255, blue: 210 / 255))
        .ignoresSafeArea()
    }
}

#Preview {
    SignUpView()
}

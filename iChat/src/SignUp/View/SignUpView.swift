//
//  SignUpView.swift
//  iChat
//
//  Created by EDSON SANTOS on 01/02/2024.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var viewModel = SignUpViewModel()
    @State var isShowPhotoLibrary = false
    
    var body: some View {
        VStack {
            Button {
                isShowPhotoLibrary = true
            } label: {
                if viewModel.image.size.width > 0 {
                    Image(uiImage: viewModel.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color("MainColor"), lineWidth: 4))
                        .shadow(radius: 7)
                } else {
                    Text("Photo")
                        .frame(width: 150, height: 150)
                        .padding()
                        .background(Color("MainColor"))
                        .foregroundColor(.white)
                        .cornerRadius(100.0)
                }
            }
            .padding(.bottom, 32)
            .sheet(isPresented: $isShowPhotoLibrary, content: {
                ImagePickerView(selectedImage: $viewModel.image)
            })
            
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
                                          backgroundColor: "MainColor"))
                
            })
            .alert(isPresented: $viewModel.formInvalid) {
                Alert(title: Text(viewModel.alertText))
            }
            
        }
        .modifier(StackStyle(paddingSize: 32, 
                             backgroundColorRed: 162,
                             backgroundColorGreen: 172,
                             backgroundColorBlue:189))
    }
}

#Preview {
    SignUpView()
}

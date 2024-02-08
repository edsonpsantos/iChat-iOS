//
//  ChatView.swift
//  iChat
//
//  Created by EDSON SANTOS on 05/02/2024.
//

import SwiftUI

struct ChatView: View {
    
    let contact: ContactModel
   
    @StateObject var viewModel = ChatViewModel()
    
    
    var body: some View {
        VStack{
            ScrollView(showsIndicators: false, content: {
                ForEach(viewModel.messages, id: \.self){ message in
                    MessageRow(message: message)
                }
            })
            Spacer()
            HStack{
                TextField("Write your message", text: $viewModel.text)
                    .autocapitalization(.none)
                    .disableAutocorrection(false)
                    .padding()
                    .background(.white)
                    .cornerRadius(24.0)
                    .overlay {
                        RoundedRectangle(cornerRadius: 24.0)
                            .strokeBorder(Color(UIColor.separator),
                                          style: StrokeStyle(lineWidth: 1.0))
                    }
                
                Button(action: {
                    viewModel.sendMessage(contact: contact)
                }, label: {
                    Text("Send")
                        .padding()
                        .background(Color("MainColor"))
                        .foregroundColor(.white)
                        .cornerRadius(24.0)
                })
                .disabled(viewModel.text.isEmpty)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
        }
        .navigationTitle(contact.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(){
            viewModel.onAppear(contact: contact)
        }
    }
}

struct MessageRow: View {
    let message: MessageModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(message.text)
                .padding(.vertical,5)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .padding(.horizontal, 10)
                .background(Color(white: 0.95))
                .frame(maxWidth: 260,
                       alignment: message.isMe ? .leading: .trailing)
            //.padding(.leading, message.isMe ? 0 : 50)
            //.padding(.trailing, message.isMe ? 50 : 0)
        }
        .frame(maxWidth: .infinity, alignment: message.isMe ? .leading: .trailing)
    }
}


#Preview {
    ChatView(contact: ContactModel(uuid: UUID().uuidString, name: "José Carlos", profileUrl: ""))
}


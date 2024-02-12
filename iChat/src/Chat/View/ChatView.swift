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
    @State var textSize: CGSize = .zero
    
    @Namespace var buttonID
    
    var body: some View {
        VStack{
            ScrollViewReader{ value in
                ScrollView(showsIndicators: false, content: {
                    //GhostView to scrollReader with scrollTo: id
                    Color.clear
                        .frame(height: 1)
                        .id(buttonID)
                    
                    LazyVStack{
                        ForEach(viewModel.messages, id: \.self){ message in
                            MessageRow(message: message)
                                .scaleEffect(x:1.0, y: -1.0, anchor:.center)
                                .onAppear{
                                    if message == viewModel.messages.last && viewModel.messages.count >= viewModel.limit{
                                        viewModel.onAppear(contact: contact)
                                    }
                                }
                        }
                        .onChange(of: viewModel.newCount){ newValue in
                            print("Count in \(newValue)")
                            if newValue > viewModel.messages.count{
                                withAnimation {
                                    value.scrollTo(buttonID)
                                }
                            }
                        }
                        .padding(.horizontal, 28)
                    }
                })
                .gesture(DragGesture().onChanged({ _ in
                    UIApplication.shared.endEditing()
                }))
                .rotationEffect(Angle(degrees: 180))
                .scaleEffect(x:-1.0, y: 1.0, anchor: .center)
            }
            Spacer()
            HStack{
                ZStack {
                    TextEditor(text: $viewModel.text)
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
                        .frame(maxHeight: (textSize.height + 38) > 100 ? 100 : textSize.height + 38 )
                    
                    Text(viewModel.text)
                        .opacity(0.0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(ViewGeometry())
                        .lineLimit(4)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 21)
                        .onPreferenceChange(ViewSizeKey.self){ size in
                            print("textsize is \(size)")
                            textSize = size
                        }
                }
                
                Button(action: {
                    viewModel.sendMessage(contact: contact)
                }, label: {
                    Text("Send")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
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

//Invisible view to background
// Listen height and size component
struct ViewGeometry: View {
    var body: some View {
        GeometryReader{ geometry in
            Color.clear
                .preference(key: ViewSizeKey.self, value: geometry.size)
        }
    }
}

//Get the prev value and pass the nextValue. Sum new values to the height value
struct ViewSizeKey: PreferenceKey {

    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        print("New value is \(value)")
        value = nextValue()
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
                .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(!message.isMe ? Color(white: 0.95) : Color("GreenLightColor")))
                .frame(maxWidth: 260,
                       alignment: !message.isMe ? .leading: .trailing)
            //.padding(.leading, message.isMe ? 0 : 50)
            //.padding(.trailing, message.isMe ? 50 : 0)
        }
        .padding(.horizontal, 2)
        .frame(maxWidth: .infinity, alignment: !message.isMe ? .leading: .trailing)
    }
}


#Preview {
    ChatView(contact: ContactModel(uuid: UUID().uuidString, 
                                   name: "José Carlos",
                                   profileUrl: ""))
}


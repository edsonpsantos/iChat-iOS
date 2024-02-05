//
//  ButtonStyle.swift
//  iChat
//
//  Created by EDSON SANTOS on 01/02/2024.
//

import SwiftUI

struct ButtonStyle: ViewModifier {
   
    var cornerRadiusSize: Float
    var backgroundColor:String
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(backgroundColor))
            .foregroundColor(.white)
            .cornerRadius(CGFloat(cornerRadiusSize))
    }
}


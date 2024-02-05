//
//  Stack.swift
//  iChat
//
//  Created by EDSON SANTOS on 03/02/2024.
//

import SwiftUI

struct StackStyle: ViewModifier {
   
    var paddingSize: Float
    var backgroundColorRed:Float
    var backgroundColorGreen:Float
    var backgroundColorBlue:Float
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity, maxHeight: .infinity/*@END_MENU_TOKEN@*/)
            .padding(.horizontal, CGFloat(paddingSize))
            .background(Color.init(red: Double(backgroundColorRed/255) ,
                                   green: Double(backgroundColorGreen/255),
                                   blue: Double(backgroundColorBlue/255)))
            .navigationBarTitleDisplayMode(.inline)
            .foregroundColor(.black)
            .ignoresSafeArea()
    }
}


//.background(Color.init(red:237 / 255 ,
//                       green: 242/255,
//                       blue: 250 / 255))

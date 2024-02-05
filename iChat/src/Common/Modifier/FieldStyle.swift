//
//  FieldStyle.swift
//  iChat
//
//  Created by EDSON SANTOS on 01/02/2024.
//

import SwiftUI


enum AutoCapitalizationOption{
    case none, words, sentences, allCharacteres
    
    func toUITextAutoCaoutalizationType()-> UITextAutocapitalizationType {
        switch self {
        case .none:
            return .none
        case .words:
            return .words
        case .sentences:
            return .sentences
        case .allCharacteres:
            return .allCharacters
        }
    }
}

enum PaddingOption {
    case leading, trailing, top, bottom, all
    
    func toEdgeSet() -> Edge.Set {
        switch self{
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        case .top:
            return .top
        case .bottom:
            return .bottom
        case .all:
            return .all
        }
    }
}


struct FieldStyle: ViewModifier {

    var autoCapitalization: AutoCapitalizationOption
    var autoCorretion: Bool
    
    var paddingOption: PaddingOption
    var paddingSize: Float
    
    var cornerRadiusSize: Float
    var lineWidthSize: Float
    
    
    func body(content: Content) -> some View {
        content
            .autocapitalization(autoCapitalization.toUITextAutoCaoutalizationType())
            .autocorrectionDisabled(autoCorretion)
            .padding()
            .background(Color.white)
            .cornerRadius(CGFloat(cornerRadiusSize))
            .overlay(
                RoundedRectangle(cornerRadius: CGFloat(cornerRadiusSize))
                    .strokeBorder(Color(UIColor.separator), style: StrokeStyle(lineWidth: CGFloat(lineWidthSize)))
            )
            .padding(paddingOption.toEdgeSet(), CGFloat(paddingSize))
    }
}

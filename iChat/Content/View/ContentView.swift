//
//  ContentView.swift
//  iChat
//
//  Created by EDSON SANTOS on 02/02/2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        if viewModel.isLogged{
            //Show message screen
            MessageView()
        } else {
            SignInView()
        }
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  Authentification_iOS_app
//
//  Created by Ivan Kramar on 15.11.2024..
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()

    var body: some View {
        if viewModel.isLoggedIn {
            ProfileView()
                .environmentObject(viewModel)
        } else {
            LoginView()
                .environmentObject(viewModel)
        }
    }
}

#Preview {
    ContentView()
}

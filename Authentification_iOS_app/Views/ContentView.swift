//
//  ContentView.swift
//  Authentification_iOS_app
//
//  Created by Ivan Kramar on 15.11.2024..
//

import SwiftUI

struct ContentView: View {
    @StateObject private var firebaseAuth = FirebaseAuth()

    var body: some View {
        if firebaseAuth.isLoggedIn {
            ProtectedView()
                .environmentObject(firebaseAuth)
        } else {
            LoginView()
                .environmentObject(firebaseAuth)
        }
    }
}

#Preview {
    ContentView()
}

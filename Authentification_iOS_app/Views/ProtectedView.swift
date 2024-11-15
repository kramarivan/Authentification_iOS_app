//
//  ProtectedView.swift
//  Authentification_iOS_app
//
//  Created by Ivan Kramar on 15.11.2024..
//
import SwiftUI

struct ProtectedView: View {
    @EnvironmentObject var contentViewModel: ContentViewModel

    var body: some View {
        VStack {
            Text("Welcome to the protected content!")
                .font(.largeTitle)
                .padding()

            Button("Logout") {
                contentViewModel.signOut()
            }
            .padding()
        }
    }
}

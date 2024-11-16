//
//  ProtectedView.swift
//  Authentification_iOS_app
//
//  Created by Ivan Kramar on 15.11.2024..
//
import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var contentViewModel: ContentViewModel
    @StateObject var viewModel = ProfileViewModel()

    var body: some View {
        VStack {
            Text("Welcome to your profile")
                .font(.largeTitle)
                .padding()
            
            Text("Email: \(viewModel.userEmail)")
            
            TextField("Name", text: $viewModel.name)
                .padding(.horizontal)
            
            TextField("Surname", text: $viewModel.surname)
                .padding(.horizontal)
            
            Button("Logout") {
                contentViewModel.signOut()
            }
            .padding()
            
            Button("Delete Account"){
                viewModel.deleteAccount { success in
                    if success {
                        contentViewModel.isLoggedIn = false
                        }
                    }
                }
            }
        }
    }

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
        ZStack {
            // Background
            Color(red: 42/255, green: 54/255, blue: 99/255).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Spacer()
                
                // Profile Header
                Text("Welcome to your profile")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
                
                // Profile Information
                VStack(spacing: 15) {
                    Text("Email: \(viewModel.user.email)")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    ZStack {
                            // Static Fields (visible when not editing)
                            if !viewModel.isEditing {
                                VStack {
                                    Text("Name: \(viewModel.user.name)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    
                                    Text("Surname: \(viewModel.user.surname)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            // Editable Fields (visible when editing)
                            if viewModel.isEditing {
                                VStack {
                                    TextField("Name", text: $viewModel.user.tempName)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    
                                    TextField("Surname", text: $viewModel.user.tempSurname)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                }
                            }
                        }
                    .frame(width: 300, height: 80) // Fixed frame width for consistent layout
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .gray.opacity(0.5), radius: 8, x: 0, y: 4)
                    }
                
                // Action Buttons
                HStack(spacing: 20) {
                    if viewModel.isEditing {
                        Button(action: {
                            viewModel.user.name = viewModel.user.tempName
                            viewModel.user.surname = viewModel.user.tempSurname
                            viewModel.saveProfileData { success in
                                if success {
                                    viewModel.isEditing = false
                                } else {
                                    viewModel.errorMessage = "Failed to save changes. Please try again."
                                }
                            }
                        }) {
                            Text("Save")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(BorderedProminentButtonStyle())
                        
                        Button(action: {
                            viewModel.isEditing = false
                        }) {
                            Text("Cancel")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(BorderedButtonStyle())
                    } else {
                        Button(action: {
                            viewModel.user.tempName = viewModel.user.name
                            viewModel.user.tempSurname = viewModel.user.surname
                            viewModel.isEditing = true
                        }) {
                            Text("Edit Profile")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(BorderedProminentButtonStyle())
                    }
                }
                .padding(.horizontal)
                Spacer()
                
                // Error or Success Message
                if let message = viewModel.errorMessage {
                    Text(message)
                        .foregroundColor(.red)
                        .font(.subheadline)
                        .padding(.top, 10)
                }
                Spacer()
                // Logout and Delete Buttons
                VStack(spacing: 10) {
                    Button("Logout") {
                        contentViewModel.signOut()
                    }
                    .buttonStyle(.bordered)
                    .tint(.gray)
                    
                    Button("Delete Account") {
                        viewModel.deleteAccount { success in
                            if success {
                                contentViewModel.isLoggedIn = false
                            }
                        }
                    }
                    .buttonStyle(.bordered)
                    .tint(.red)
                }
                .padding(.top, 20)
                
            }
            .padding()
        }
    }
}

#Preview {
    ProfileView()
}

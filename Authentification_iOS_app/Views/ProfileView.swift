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
            Spacer()
            
            Text("Welcome to your profile")
                .font(.largeTitle)
                .padding()
            
            Text("Email: \(viewModel.user.email)")
            if viewModel.isEditing {
                TextField("Name", text: $viewModel.user.tempName)
                    .padding(.horizontal)
                
                TextField("Surname", text: $viewModel.user.tempSurname)
                    .padding(.horizontal)
            } else {
                Text("Name: \(viewModel.user.name)")
                Text("Surname: \(viewModel.user.surname)")
            }
            
            
            HStack {
                if viewModel.isEditing {
                    // Save Button
                    Button("Save") {
                        viewModel.user.name = viewModel.user.tempName
                        viewModel.user.surname = viewModel.user.tempSurname
                        viewModel.saveProfileData { success in
                            if success {
                                viewModel.isEditing = false
                            } else {
                                viewModel.errorMessage = "Failed to save changes. Please try again."
                            }
                        }
                    }
                    .padding()
                    // Cancel Button
                    Button("Cancel") {
                        viewModel.isEditing = false
                    }
                    .padding()
                    
                } else {
                    // Edit Button
                    Button("Edit") {
                        viewModel.user.tempName = viewModel.user.name
                        viewModel.user.tempSurname = viewModel.user.surname
                        viewModel.isEditing = true
                    }
                    .padding()
                }
            }
            
            Spacer()
            
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

#Preview {
    ProfileView()
}

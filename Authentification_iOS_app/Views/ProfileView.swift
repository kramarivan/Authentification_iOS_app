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
            
            Text("Email: \(viewModel.userEmail)")
            if viewModel.isEditing {
                TextField("Name", text: $viewModel.tempName)
                    .padding(.horizontal)
                
                TextField("Surname", text: $viewModel.tempSurname)
                    .padding(.horizontal)
            } else {
                Text("Name: \(viewModel.name)")
                Text("Surname: \(viewModel.surname)")
            }
            
            
            HStack {
                if viewModel.isEditing {
                    // Save Button
                    Button("Save") {
                        viewModel.name = viewModel.tempName
                        viewModel.surname = viewModel.tempSurname
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
                        viewModel.tempName = viewModel.name
                        viewModel.tempSurname = viewModel.surname
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

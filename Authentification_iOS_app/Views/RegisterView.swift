//
//  RegisterView.swift
//  Authentification_iOS_app
//
//  Created by Ivan Kramar on 15.11.2024..
//
import SwiftUI

struct RegisterView: View {
    @StateObject var registerViewModel = RegisterViewModel()
    @EnvironmentObject var contentViewModel: ContentViewModel
    
    var body: some View {
        VStack(spacing: 20){
            TextField("Username", text: $registerViewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding(.horizontal)
        
        
        SecureField("Password", text: $registerViewModel.password)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .autocapitalization(.none)
            .keyboardType(.default)
            .padding(.horizontal)
            
            if let error = registerViewModel.registerError {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
            }
        
        Button("Register") {
            registerViewModel.register { success in
                if success {
                    contentViewModel.isLoggedIn = true
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(8)
        .padding(.horizontal)
        }
    }
}

#Preview {
    RegisterView()
}



//
//  LoginView.swift
//  Authentification_iOS_app
//
//  Created by Ivan Kramar on 15.11.2024..
//
import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @EnvironmentObject var firebaseAuth: FirebaseAuth
    @StateObject private var loginViewModel = LoginViewModel()

        var body: some View {
            VStack(spacing: 20) {
                TextField("Username", text: $loginViewModel.username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding(.horizontal)

                SecureField("Password", text: $loginViewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                if let loginError = loginViewModel.loginError {
                    Text(loginError)
                        .foregroundColor(.red)
                        .padding()
                }

                Button("Login") {
                    loginViewModel.loginUser { success in
                        if success {
                            firebaseAuth.isLoggedIn = true
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
            .padding()
        }
    }

#Preview {
    LoginView()
}

//
//  LoginView.swift
//  Authentification_iOS_app
//
//  Created by Ivan Kramar on 15.11.2024..
//
import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @EnvironmentObject var contentViewModel: ContentViewModel
    @StateObject private var loginViewModel = LoginViewModel()

        var body: some View {
            NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                
                TextField("Email", text: $loginViewModel.user.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding(.horizontal)

                SecureField("Password", text: $loginViewModel.user.password)
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
                
                Spacer()

                
                NavigationLink(destination: RegisterView()) {
                    Text("Don't have an account? Register here.")
                    }
                }.padding()
            }
        }
    }

#Preview {
    LoginView()
}

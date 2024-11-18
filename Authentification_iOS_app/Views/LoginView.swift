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
            ZStack{
                Color(.systemGray6).edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Spacer()
                    
                    Text("Welcome Back!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Text("Please log in to continue")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    VStack(spacing: 15) {
                        ZStack {
                            // Email Input Field
                            VStack {
                                Text("Email")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                TextField("Enter your email", text: $loginViewModel.user.email)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .autocapitalization(.none)
                            }
                            .padding()
                        }
                        .frame(width: 300)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .gray.opacity(0.5), radius: 8, x: 0, y: 4)
                        
                        ZStack {
                            // Password Input Field
                            VStack {
                                Text("Password")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                SecureField("Enter your password", text: $loginViewModel.user.password)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            .padding()
                        }
                        .frame(width: 300)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .gray.opacity(0.5), radius: 8, x: 0, y: 4)
                    }
                    
                    if let loginError = loginViewModel.loginError {
                        Text(loginError)
                            .foregroundColor(.red)
                            .font(.subheadline)
                            .padding()
                    }
                    
                    Button("Login") {
                        loginViewModel.loginUser { success in
                            if success {
                                contentViewModel.isLoggedIn = true
                            }
                        }
                    }
                    .frame(maxWidth: 300)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(color: .blue.opacity(0.5), radius: 8, x: 0, y: 4)
                    .padding(.top)
                    
                    Spacer()
                    
                    NavigationLink(destination: RegisterView()) {
                        Text("Don't have an account? Register here.")
                            .font(.footnote)
                            .foregroundColor(.blue)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    LoginView()
}


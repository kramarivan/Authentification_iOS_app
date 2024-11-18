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
        ZStack{
            Color(.systemGray6).edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Spacer()
                
                Text("Create an Account")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text("Fill in your details below to get started")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                VStack(spacing: 15) {
                    ZStack {
                        VStack {
                            Text("Email")
                                .font(.caption)
                                .foregroundColor(.gray)
                            TextField("Enter your email", text: $registerViewModel.user.email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                        }
                        .padding()
                    }
                    .frame(width: 300)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: .gray.opacity(0.5), radius: 8, x: 0, y: 4)
                    
                    ZStack {
                        VStack {
                            Text("Password")
                                .font(.caption)
                                .foregroundColor(.gray)
                            SecureField("Enter your password", text: $registerViewModel.user.password)
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
                        VStack {
                            Text("Name (optional)")
                                .font(.caption)
                                .foregroundColor(.gray)
                            TextField("Enter your name", text: $registerViewModel.user.name)
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
                        VStack {
                            Text("Surname (optional)")
                                .font(.caption)
                                .foregroundColor(.gray)
                            TextField("Enter your surname", text: $registerViewModel.user.surname)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocapitalization(.none)
                        }
                        .padding()
                    }
                    .frame(width: 300)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: .gray.opacity(0.5), radius: 8, x: 0, y: 4)
                }
                
                if let error = registerViewModel.registerError {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .font(.subheadline)
                        .padding()
                }
                
                Button("Sign Up") {
                    registerViewModel.register { success in
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
            }
            .padding()
        }
    }
}

#Preview {
    RegisterView()
}




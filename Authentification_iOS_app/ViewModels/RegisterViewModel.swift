//
//  RegisterViewModel.swift
//  Authentification_iOS_app
//
//  Created by Ivan Kramar on 15.11.2024..
//
import SwiftUI
import FirebaseAuth

class RegisterViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var registerError: String?
    
    func register(completion: @escaping (Bool) -> Void) {
        guard !username.isEmpty, !password.isEmpty else {
            registerError = "Username and password cannot be empty."
            completion(false)
            return
        }
        
        Auth.auth().createUser(withEmail: username, password: password) { [weak self] _, error in
            DispatchQueue.main.async {
                if let error = error {
                    // If authentication fails, update the error message and notify failure
                    self?.registerError = error.localizedDescription
                    completion(false)
                } else {
                    // If successful, clear any error message and notify success
                    self?.registerError = nil
                    completion(true)
                }
            }
        }
        
    }
}

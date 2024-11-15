//
//  LoginViewModel.swift
//  Authentification_iOS_app
//
//  Created by Ivan Kramar on 15.11.2024..
//


import SwiftUI
import FirebaseAuth

/// A ViewModel to handle login functionality and manage related state
class LoginViewModel: ObservableObject {
    // User-provided email/username
    @Published var username = ""
    // User-provided password
    @Published var password = ""
    // Error message to display in case of login failure
    @Published var loginError: String?

    /// Attempts to log in the user with the provided credentials.
    /// - Parameter completion: A closure that returns `true` if login is successful, or `false` otherwise.
    func loginUser(completion: @escaping (Bool) -> Void) {
        // Ensure both username and password are not empty
        guard !username.isEmpty, !password.isEmpty else {
            loginError = "Username and password cannot be empty."
            completion(false)
            return
        }

        // Attempt to authenticate with Firebase using email and password
        Auth.auth().signIn(withEmail: username, password: password) { [weak self] _, error in
            // Ensure UI updates happen on the main thread
            DispatchQueue.main.async {
                if let error = error {
                    // If authentication fails, update the error message and notify failure
                    self?.loginError = error.localizedDescription
                    completion(false)
                } else {
                    // If successful, clear any error message and notify success
                    self?.loginError = nil
                    completion(true)
                }
            }
        }
    }
}

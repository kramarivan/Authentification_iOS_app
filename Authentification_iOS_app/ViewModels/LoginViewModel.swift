//
//  LoginViewModel.swift
//  Authentification_iOS_app
//
//  Created by Ivan Kramar on 15.11.2024..
//


import SwiftUI
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var loginError: String?

    func loginUser(completion: @escaping (Bool) -> Void) {
        guard !username.isEmpty, !password.isEmpty else {
            loginError = "Username and password cannot be empty."
            completion(false)
            return
        }

        Auth.auth().signIn(withEmail: username, password: password) { [weak self] _, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.loginError = error.localizedDescription
                    completion(false)
                } else {
                    self?.loginError = nil
                    completion(true)
                }
            }
        }
    }
}

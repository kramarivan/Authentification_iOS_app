//
//  RegisterViewModel.swift
//  Authentification_iOS_app
//
//  Created by Ivan Kramar on 15.11.2024..
//
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class RegisterViewModel: ObservableObject {
    @Published var user = User()
    @Published var registerError: String?
    
    private let db = Firestore.firestore()
    
    func register(completion: @escaping (Bool) -> Void) {
        guard !user.email.isEmpty, !user.password.isEmpty else {
            registerError = "Username and password cannot be empty."
            completion(false)
            return
        }
        
        // Create user with email and password
        Auth.auth().createUser(withEmail: user.email, password: user.password) { [weak self] authResult, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.registerError = error.localizedDescription
                    completion(false)
                }
                return
            }
            
            // Store additional user data in Firestore
            if let user = authResult?.user {
                let userData: [String: Any] = [
                    "name": self?.user.name ?? "",
                    "surname": self?.user.surname ?? "",
                    "email": self?.user.email ?? "",
                    "createdAt": FieldValue.serverTimestamp()
                ]
                
                self?.db.collection("users").document(user.uid).setData(userData) { error in
                    DispatchQueue.main.async {
                        if let error = error {
                            self?.registerError = error.localizedDescription
                            completion(false)
                        } else {
                            self?.registerError = nil
                            completion(true)
                        }
                        
                    }
                }
            }
        }
    }
}

//
//  ProfileViewModel.swift
//  Authentification_iOS_app
//
//  Created by Ivan Kramar on 16.11.2024..
//


import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    @Published var userEmail: String = ""
    @Published var deleteError: String?
    @Published var name: String = ""
    @Published var surname: String = ""
    
    private let db = Firestore.firestore()
    
    init() {
        fetchUserData()
    }

    /// Fetches the currently logged-in user's email.
    private func fetchUserData() {
        guard let user = Auth.auth().currentUser else { return }
        
        // Fetch user email from FirebaseAuth
        userEmail = user.email ?? "No email found"
        
        // Fetch additional user data from Firestore
        let docRef = db.collection("users").document(user.uid)
        docRef.getDocument { [weak self] document, error in
            if let document = document, document.exists {
                let data = document.data()
                self?.name = data?["name"] as? String ?? "No name"
                self?.surname = data?["surname"] as? String ?? "No surname"
            }
        }
    }
    
    func deleteAccount(completion: @escaping (Bool) -> Void) {
            guard let user = Auth.auth().currentUser else {
                deleteError = "No user is logged in."
                completion(false)
                return
            }

            user.delete { [weak self] error in
                DispatchQueue.main.async {
                    if let error = error {
                        self?.deleteError = error.localizedDescription
                        completion(false)
                    } else {
                        self?.deleteError = nil
                        completion(true)
                    }
                }
            }
        }
    }

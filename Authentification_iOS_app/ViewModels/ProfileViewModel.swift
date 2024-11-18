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
    @Published var user = User()
    @Published var errorMessage: String?
    @Published var isEditing: Bool = false
    
    private let db = Firestore.firestore()
    
    init() {
        fetchUserData()
    }

    /// Fetches the currently logged-in user's email.
    func fetchUserData() {
        guard let FBuser = Auth.auth().currentUser else { return }
        
        // Fetch user email from FirebaseAuth
        user.email = FBuser.email ?? "No email found"
        
        // Fetch additional user data from Firestore
        let docRef = db.collection("users").document(FBuser.uid)
        docRef.getDocument { [weak self] document, error in
            if let document = document, document.exists {
                let data = document.data()
                self?.user.name = data?["name"] as? String ?? "No name"
                self?.user.surname = data?["surname"] as? String ?? "No surname"
            }
        }
    }
    
    func deleteAccount(completion: @escaping (Bool) -> Void) {
            guard let FBuser = Auth.auth().currentUser else {
                errorMessage = "No user is logged in."
                completion(false)
                return
            }
        
        // Get a reference to the Firestore document
            let userDocRef = db.collection("users").document(FBuser.uid)
            
            // Delete the Firestore document first
            userDocRef.delete { [weak self] error in
                if let error = error {
                    DispatchQueue.main.async {
                        self?.errorMessage = "Failed to delete user data: \(error.localizedDescription)"
                        completion(false)
                    }
                    return
                }

            FBuser.delete { [weak self] error in
                DispatchQueue.main.async {
                    if let error = error {
                        self?.errorMessage = error.localizedDescription
                        completion(false)
                    } else {
                        self?.errorMessage = nil
                        completion(true)
                    }
                }
            }
        }
    }
    
    func saveProfileData(completion: @escaping (Bool) -> Void) {
            guard let userId = Auth.auth().currentUser?.uid else {
                completion(false)
                return
            }

            db.collection("users").document(userId).setData([
                "name": user.name,
                "surname": user.surname
            ], merge: true) { error in
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    completion(false)
                } else {
                    completion(true)
                }
            }
        }
    }

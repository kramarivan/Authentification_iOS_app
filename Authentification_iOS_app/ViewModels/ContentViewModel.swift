//
//  ContentViewModel.swift
//  Authentification_iOS_app
//
//  Created by Ivan Kramar on 15.11.2024..
//


import SwiftUI
import FirebaseAuth

/// ViewModel for managing the primary navigation and authentication state in ContentView.
class ContentViewModel: ObservableObject {
    
    @Published var isLoggedIn = false

    private var authStateListenerHandle: AuthStateDidChangeListenerHandle?

    /// Initializes the ContentViewModel and sets up a listener for authentication state changes.
    init() {
        self.isLoggedIn = Auth.auth().currentUser != nil
        authStateListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.isLoggedIn = user != nil
            }
        }
    }

    /// Cleanup to remove the authentication state listener.
    deinit {
        if let handle = authStateListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }

    /// Sign out the current user.
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isLoggedIn = false
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}

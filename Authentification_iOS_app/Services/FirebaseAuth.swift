//
//  FirebaseAuth.swift
//  Authentification_iOS_app
//
//  Created by Ivan Kramar on 15.11.2024..
//

import SwiftUI
import FirebaseAuth

/// A service class to manage Firebase authentication and observe the user's login state.
class FirebaseAuth: ObservableObject {
    // A published property to track whether the user is currently logged in.
    @Published var isLoggedIn = false

    /// Initializes the FirebaseAuth object and sets up a listener for authentication state changes.
    init() {
        // Check if a user is already logged in at app launch
        self.isLoggedIn = Auth.auth().currentUser != nil

        // Listen for changes in the authentication state
        Auth.auth().addStateDidChangeListener { _, user in
            // Update the `isLoggedIn` property based on the current user state
            self.isLoggedIn = user != nil
        }
    }

    /// Signs out the current user and updates the login state.
    func signOut() {
        // Attempt to sign out the user
        try? Auth.auth().signOut()
        // Update the `isLoggedIn` property to reflect the logged-out state
        isLoggedIn = false
    }
}

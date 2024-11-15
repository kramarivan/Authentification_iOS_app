//
//  FirebaseAuth.swift
//  Authentification_iOS_app
//
//  Created by Ivan Kramar on 15.11.2024..
//

import SwiftUI
import FirebaseAuth

class FirebaseAuth: ObservableObject {
    @Published var isLoggedIn = false

    init() {
        self.isLoggedIn = Auth.auth().currentUser != nil
        Auth.auth().addStateDidChangeListener { _, user in
            self.isLoggedIn = user != nil
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        isLoggedIn = false
    }
}

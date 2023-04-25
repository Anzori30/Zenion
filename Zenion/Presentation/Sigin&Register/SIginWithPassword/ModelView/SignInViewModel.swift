//
//  SignInWithPasswordView.swift
//  Zenion
//
//  Created by macbook on 12.04.23.
//

import SwiftUI
import Firebase
class SignInViewModel: ObservableObject {
    @Published var isSignedIn = false
    @Published var alert = false
    @Published var errors = ""
    @Published var ActivityIndicator = false
    var valueToSave = Bool()
    let defaults = UserDefaults.standard

    func signIn(withEmail email: String, password: String) {
        self.ActivityIndicator = true
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                // Handle sign in errors
                print("Error signing in: \(error.localizedDescription)")
                self.errors = "\(error.localizedDescription)"
                self.ActivityIndicator = false
                self.alert = true
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.alert = false
                    self.isSignedIn = true
                    self.ActivityIndicator = false
                }
                self.valueToSave = true
                self.defaults.set(self.valueToSave, forKey: "isLogined")
                if let user = authResult?.user {
                   let displayName = user.displayName ?? "Unknown"
                    self.defaults.set(displayName, forKey: "Name")
                    self.defaults.set(email, forKey: "Email")
                 }
                print("Sign in successful")
            }
        }
    }

}




//
//  ResetPasswordViewModelView.swift
//  Zenion
//
//  Created by macbook on 12.04.23.
//

import SwiftUI
import Firebase

class ResetPasswordModelView: ObservableObject {
    @Published var isSignedIn = false
    @Published var alert = false
    @Published var info = ""
    @Published var activityIndicator = Bool()
    func signIn(withEmail email: String) {
        self.activityIndicator = true
        let auth = Auth.auth()
        auth.sendPasswordReset(withEmail: email) { error in
            if let error = error{
                self.info = "\(error.localizedDescription)"
                self.activityIndicator = false
                self.alert = true
            }
            else{
                self.info = "Recovery link sent successfully"
                self.activityIndicator = false
                self.alert = true
            }
        }
    }
}




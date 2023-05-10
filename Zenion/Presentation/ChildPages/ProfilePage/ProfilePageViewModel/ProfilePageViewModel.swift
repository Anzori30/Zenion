//
//  ProfilePageViewModel.swift
//  Zenion
//
//  Created by macbook on 02.05.23.
//

import SwiftUI
import Firebase
class ProfilePageViewModel: ObservableObject {
    @Published var indicator = false
    @Published  var imageUrl = String()
    @Published var showErrorAlert = Bool()
     @Published var errorDescription = String()
     let defaults = UserDefaults.standard
     let userEmail = UserDefaults.standard.string(forKey: "Email") ?? "Unknown"
     var valueToSave = true
    init() {
        takeLInk()
    }
    func takeLInk(){
        PhotoUploader().imageLink()
        NotificationCenter.default.addObserver(self, selector: #selector(handleMovieNotification(_:)), name: Notification.Name("UploadPhoto"), object: nil)
    }
    
    @objc func handleMovieNotification(_ notification: Notification) {
        imageUrl = ""
        if let URL = notification.object as? String, !URL.isEmpty {
            imageUrl = URL
            DispatchQueue.main.asyncAfter(deadline: .now() + 4){
                self.indicator = false
            }
        }
        else{
            imageUrl = "https://firebasestorage.googleapis.com/v0/b/zenion-19e7e.appspot.com/o/images%2FBaseImage%2Fdownload.png?alt=media&token=b9cd0b63-db6b-47b9-9032-6ed037c27b85"
        }
    }
    func deleteAccount(){
        Auth.auth().currentUser?.delete { error in
            if let error = error {
                if let errorCode = AuthErrorCode.Code(rawValue: error._code) {
                    if errorCode == .requiresRecentLogin {
                        // The user needs to re-authenticate before they can delete their account
                        self.showErrorAlert = true
                        self.errorDescription = "Please re-authenticate to delete your account."
                    } else {
                        // There was some other error while deleting the user's account
                        self.showErrorAlert = true
                        self.errorDescription = "Error deleting user: \(error.localizedDescription)"
                    }
                } else {
                    // Handle the case where the error code is not a valid AuthErrorCode.Code value
                    self.showErrorAlert = true
                    self.errorDescription = "Unknown error occurred while deleting user."
                }
            } else {
                UserViewModel().logOut()
                self.errorDescription = "User deleted successfully."
                self.showErrorAlert = true
                self.indicator = true
                
            }
        }
    }
    
    func resetPassword(){
        ResetPasswordModelView().signIn(withEmail: userEmail){ info in
            self.errorDescription = info
            self.showErrorAlert = true
        }
    }
}
  


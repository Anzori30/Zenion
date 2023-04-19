//
//  RegisterViewModel.swift
//  Zenion
//
//  Created by macbook on 12.04.23.
//

import SwiftUI
import Firebase
import FirebaseStorage

class RegisterViewModel: ObservableObject {
    @Published var isSignedIn = false
    @Published var alert = false
    @Published var info = ""
    @Published var activityIndicator = false
    @Published var image: UIImage?
    var photoUploader = PhotoUploader()
    
    private let storage = Storage.storage()
    private let storageReference: StorageReference
    
    init() {
        storageReference = storage.reference()
    }
    
    func registerUser(name: String, email: String, password: String) {
           if name == ""{
               self.alert = true
               self.info =  "Please provide name"
           }
           else if email == ""{
               self.alert = true
               self.info =  "Please provide email"
           }
           else if password == ""{
               self.alert = true
               self.info =  "Please enter a password"
           }
           else{
               activityIndicator = true
               Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                   if let error = error {
                       self.alert = true
                       self.info =  "\(error.localizedDescription)"
                       self.activityIndicator = false
                   }
                   else {
                       // User registered successfully
                       self.activityIndicator = false
                       self.alert = true
                       self.isSignedIn = true
                       self.info =  "User registered successfully!"
                   }
               }
           }
       } 
}


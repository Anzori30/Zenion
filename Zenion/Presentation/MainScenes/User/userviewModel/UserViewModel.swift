//
//  UserViewModel.swift
//  Zenion
//
//  Created by macbook on 19.04.23.
//

import SwiftUI
import Firebase
import GoogleSignIn
class UserViewModel:ObservableObject{
    let firebaseAuth = Auth.auth()
    var Movies = [movie]()
    var imageUrl = String()
    @Published var ActivityIndicator = false
    @Published var historyMovies = [movie]()
    var valueToSave = Bool()
    let userName = UserDefaults.standard.string(forKey: "Name") ?? "Unknown"
    let userEmail = UserDefaults.standard.string(forKey: "Email") ?? "Unknown"
    let defaults = UserDefaults.standard
   @Published var restart = false
    init() {
        takeLink()
        takeHistory()
        NotificationCenter.default.addObserver(self, selector: #selector(handleMovieNotification(_:)), name:Notification.Name("MovieNotification"), object: nil)
    }
    func takeHistory(){
        UserHistory().printAllHistory()
        NotificationCenter.default.addObserver(self, selector: #selector(MovieNotification(_:)), name:Notification.Name("History"), object: nil)
    }
    func takeLink(){
        restart = true
        PhotoUploader().imageLink()
        NotificationCenter.default.addObserver(self, selector: #selector(uploadPhoto(_:)), name: Notification.Name("UploadPhoto"), object: nil)
    }
    func logOut(){
        ActivityIndicator = true
        self.valueToSave = false
        self.defaults.set(self.valueToSave, forKey: "isLogined")
        do {
          try firebaseAuth.signOut()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            NotificationCenter.default.post(name: NSNotification.Name("LogOut"), object: nil)
          }
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        
    }    // all movies
    @objc func handleMovieNotification(_ notification: Notification) {
        if let movies = notification.object as? [movie] {
            UserHistory().printAllHistory()
            Movies = movies
        }
    }
    // history
    @objc func MovieNotification(_ notification: Notification) {
        historyMovies = []
        guard let history = notification.object as? [SaveHistory], !history.isEmpty else { return }
        for savedHistory in history {
            if let movie = Movies.first(where: { $0.name == savedHistory.MovieName }) {
                historyMovies.append(movie)
            }
        }
    }
    @objc func uploadPhoto(_ notification: Notification) {
        imageUrl = ""
        if let URL = notification.object as? String, !URL.isEmpty {
              imageUrl = URL
        }
        else{
            imageUrl = "https://firebasestorage.googleapis.com/v0/b/zenion-19e7e.appspot.com/o/images%2FBaseImage%2Fdownload.png?alt=media&token=b9cd0b63-db6b-47b9-9032-6ed037c27b85"
        }
    }
}

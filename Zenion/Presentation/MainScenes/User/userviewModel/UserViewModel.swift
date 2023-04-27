//
//  UserViewModel.swift
//  Zenion
//
//  Created by macbook on 19.04.23.
//

import SwiftUI

class UserViewModel:ObservableObject{
    var Movies = [movie]()
    @Published var ActivityIndicator = false
   @Published var historyMovies = [movie]()
    var valueToSave = Bool()
    let userName = UserDefaults.standard.string(forKey: "Name") ?? "Unknown"
    let userEmail = UserDefaults.standard.string(forKey: "Email") ?? "Unknown"
    let defaults = UserDefaults.standard
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(MovieNotification(_:)), name:Notification.Name("History"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleMovieNotification(_:)), name:Notification.Name("MovieNotification"), object: nil)
    }
    func logOut(){
        ActivityIndicator = true
        self.valueToSave = false
        self.defaults.set(self.valueToSave, forKey: "isLogined")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            NotificationCenter.default.post(name: NSNotification.Name("LogOut"), object: nil)
        }
    }    // all movies
    @objc func handleMovieNotification(_ notification: Notification) {
        if let movies = notification.object as? [movie] {
            HistoryUpload().printAllHistory()
            Movies = movies
        }
    }
    // history
    @objc func MovieNotification(_ notification: Notification) {
        guard let history = notification.object as? [SaveHistory], !history.isEmpty else { return }
        historyMovies = []
        for savedHistory in history {
            if let movie = Movies.first(where: { $0.name == savedHistory.MovieName }) {
                historyMovies.append(movie)
            }
        }
    }

}

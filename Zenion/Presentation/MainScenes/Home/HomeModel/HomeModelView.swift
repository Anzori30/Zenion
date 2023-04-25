//
//  HomeModelView.swift
//  Zenion
//
//  Created by macbook on 15.04.23.
//

import SwiftUI
class HomeModelView: ObservableObject {
    var Homemovies = [movie]()
   @Published var showMovies = false
    @Published var ActivityIndicator = true
    init() {
        FirebaseDatabaseInfo().startHTTP()
        NotificationCenter.default.addObserver(self, selector: #selector(handleMovieNotification(_:)), name: Notification.Name("MovieNotification"), object: nil)
    }

    @objc func handleMovieNotification(_ notification: Notification) {
        if let movies = notification.object as? [movie] {
            Homemovies = movies
            showMovies = true
            ActivityIndicator = false
        }
    }


}


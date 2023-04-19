//
//  searchViewModel.swift
//  Zenion
//
//  Created by macbook on 18.04.23.
//

import SwiftUI

class searchViewModel: ObservableObject {
    var Searchmovies = [movie]()
    @Published var showMovies = false
    @Published var ActivityIndicator = true

    init() {
        FirebaseDatabaseInfo().startHTTP()
        NotificationCenter.default.addObserver(self, selector: #selector(handleMovieNotification(_:)), name: Notification.Name("MovieNotification"), object: nil)
    }
    @objc func handleMovieNotification(_ notification: Notification) {
        if let movies = notification.object as? [movie] {
            Searchmovies = movies
            showMovies = true
            ActivityIndicator = false
            print("Received notification with movies: \(Searchmovies)")
        }
    }
}

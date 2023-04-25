//
//  FavoriteViewModel.swift
//  Zenion
//
//  Created by macbook on 25.04.23.
//
import SwiftUI

class FavoriteViewModel: ObservableObject {
    
    @Published var isFavorite = [movie]()
    var movies = [movie]()

    init() {
       start()
    }
    func start(){
        NotificationCenter.default.addObserver(self, selector: #selector(MovieNotification(_:)), name: Notification.Name("MovieNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleMovieNotification(_:)), name: Notification.Name("Favorite"), object: nil)
    }
    @objc func MovieNotification(_ notification: Notification) {
        movies = notification.object as? [movie] ?? []
    }

    @objc func handleMovieNotification(_ notification: Notification) {
        isFavorite = []
        guard let favoritemovies = notification.object as? [String] else { return }
        for movie in movies {
            if favoritemovies.contains(movie.name) && !isFavorite.contains(movie) {
                isFavorite.append(movie)
            }
        }
    }
}


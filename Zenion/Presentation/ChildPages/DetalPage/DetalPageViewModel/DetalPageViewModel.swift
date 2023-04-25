//
//  DetalPageViewModel.swift
//  Zenion
//
//  Created by macbook on 24.04.23.
//

import SwiftUI

class DetalPageViewModel: ObservableObject {
    
    @Published var bookmark = "bookmark"
    var isFavorite = [movie]()
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleMovieNotification(_:)), name: Notification.Name("Favorite"), object: nil)
    }
    
    @objc func handleMovieNotification(_ notification: Notification) {
        if let movies = notification.object as? [String], !movies.isEmpty {
            if isFavorite.contains(where: { movie in movies.contains(movie.name) }) {
                bookmark = "bookmark.fill"
            } else {
                bookmark = "bookmark"
            }
        }
    }
}

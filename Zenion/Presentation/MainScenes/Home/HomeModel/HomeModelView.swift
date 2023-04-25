//
//  HomeModelView.swift
//  Zenion
//
//  Created by macbook on 15.04.23.
//

import SwiftUI
class HomeModelView: ObservableObject {
    var Homemovies = [movie]()
    var trailer = [movie]()
    var topMovie = [movie]()
   @Published var showMovies = false
    @Published var isTake = Bool()
    @Published var ActivityIndicator = true
//    @Published var movieNames = [String]()
    init() {
        FirebaseDatabaseInfo().startHTTP()
        Uploadfavorite().printAllFavorites()
        NotificationCenter.default.addObserver(self, selector: #selector(handleMovieNotification(_:)), name: Notification.Name("MovieNotification"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(MovieNotification(_:)), name:Notification.Name("FirebaseFavorite"), object: nil)
    }
    @objc func handleMovieNotification(_ notification: Notification) {
        if let movies = notification.object as? [movie] {
            Homemovies = movies
            showMovies = true
            ActivityIndicator = false
            trailerFilter()
            top()
        }
    }
//    @objc func MovieNotification(_ notification: Notification) {
//              if let movies = notification.object as? [String], !movies.isEmpty {
//               movieNames = movies
//               isTake = true
//        }
//    }
    
    func trailerFilter() {
        var uniqueTrailers = Set<movie>()
        for item in Homemovies {
            if item.video.isEmpty {
                uniqueTrailers.insert(item)
            }
        }
        trailer = Array(uniqueTrailers)
    }
    func top() {
        var uniqueTrailers = Set<movie>()
        for item in Homemovies {
            if item.star > 5.5 {
                uniqueTrailers.insert(item)
            }
        }
        topMovie = Array(uniqueTrailers)
    }


    
}


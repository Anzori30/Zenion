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
    var banerMovies = [movie]()
    @Published  var historyMovies = [movie]()
    @Published var showMovies = false
    @Published var isTake = Bool()
    @Published var ActivityIndicator = true
//    @Published var movieNames = [String]()
    init() {
        Uploadfavorite().printAllFavorites()
       takeMovie()
        NotificationCenter.default.addObserver(self, selector: #selector(MovieNotification(_:)), name:Notification.Name("History"), object: nil)
    }
    func takeMovie(){
        FirebaseDatabaseInfo().startHTTP()
        NotificationCenter.default.addObserver(self, selector: #selector(handleMovieNotification(_:)), name: Notification.Name("MovieNotification"), object: nil)
    }
    // all movies
    @objc func handleMovieNotification(_ notification: Notification) {
        if let movies = notification.object as? [movie] {
            HistoryUpload().printAllHistory()
            Homemovies = movies
            showMovies = true
            ActivityIndicator = false
            banerFilters()
            trailerFilter()
            top()
        }
    }
  
    // Mark  filters
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
    func banerFilters(){
        var counter = 0
            var uniqueTrailers = Set<movie>()
            for item in Homemovies {
                if item.star > 5.0 && item.photo != "" && counter <= 6{
                    uniqueTrailers.insert(item)
                    counter += 1
                }
            }
            banerMovies = Array(uniqueTrailers)
    }
    // history
    @objc func MovieNotification(_ notification: Notification) {
        guard let history = notification.object as? [SaveHistory], !history.isEmpty else { return }

        historyMovies = []
        for savedHistory in history {
            if savedHistory.fullTime <= savedHistory.endTime,
               let movie = Homemovies.first(where: { $0.name == savedHistory.MovieName }) {
                historyMovies.append(movie)
            }
        }
    }


    
}


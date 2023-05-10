//
//  AllModelView.swift
//  Zenion
//
//  Created by macbook on 18.04.23.
//

import SwiftUI

class AllModelView:ObservableObject{
    var Movie = [movie]()
    @Published var showMovies = false
    @Published var ActivityIndicator = true
    @Published var historyMovies = [SaveHistory]()
    var reset = Bool()
    init() {
        ImportMovies().startHTTP()
        NotificationCenter.default.addObserver(self, selector: #selector(handleMovieNotification(_:)), name: Notification.Name("MovieNotification"), object: nil)
        history()
    }
    @objc func handleMovieNotification(_ notification: Notification) {
        if let movies = notification.object as? [movie] {
            Movie = movies
            showMovies = true
            ActivityIndicator = false
//            print("Received notification with movies: \(Homemovies)")
        }
    }
    func history(){
        UserHistory().printAllHistory(completion: { history in
            self.reset = false
            self.historyMovies = []
            guard !history.isEmpty else { return }
            for savedHistory in history {
                self.historyMovies.append(savedHistory)
            }
            self.reset = true
        })
    }
}

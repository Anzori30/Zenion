//
//  DetalPageViewModel.swift
//  Zenion
//
//  Created by macbook on 24.04.23.
//

import SwiftUI

class DetalPageViewModel: ObservableObject {
    private let shareBaseURL = "https://example.com/movie/"
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
    func shareItem(movie:movie) {
        let encodedMovieName = movie.name.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        let urlString = shareBaseURL + encodedMovieName
        if let url = URL(string: urlString) {
            let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
        }
    }
}

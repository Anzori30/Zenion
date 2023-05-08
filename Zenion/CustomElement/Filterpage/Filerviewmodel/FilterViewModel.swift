//
//  FilterViewModel.swift
//  Zenion
//
//  Created by macbook on 30.04.23.
//

import SwiftUI

class FilterViewModel: ObservableObject {
    var filtermovies = [movie]()
    var yearsliderPosition: ClosedRange<Float> = 1800...2023
    @Published  var genre = [String]()
   @Published  var country = [String]()
    init() {
        startFilter()
        FirebaseDatabaseInfo().startHTTP()
        NotificationCenter.default.addObserver(self, selector: #selector(handleMovieNotification(_:)), name: Notification.Name("MovieNotification"), object: nil)
    }
    @objc func handleMovieNotification(_ notification: Notification) {
        genre = []
        genre.append("All")
        country.append("All")
        if let movies = notification.object as? [movie] {
            filtermovies = movies
            for movie in movies {
                for movieGenre in movie.genre {
                    if !genre.contains(movieGenre) {
                        genre.append(movieGenre)
                    }
                }
                for countrys in movie.location{
                    if !country.contains(countrys){
                        country.append(countrys)
                    }
                }
            }
        }
    }
    var type = Int()
    var genres = String()
    var countrys = String()
    var minYear = Int()
    var maxYear = Int()
    var minRating = Double()
    var maxRating = Double()
    var hideViewing = Bool()
    let defaults = UserDefaults.standard

    func startFilter(){
        let decoder = JSONDecoder()
        if let savedFilter = defaults.object(forKey: "filterMovies") as? Data {
            if let loadedFilter = try? decoder.decode(filterMovies.self, from: savedFilter) {
                type = loadedFilter.type
                genres = loadedFilter.genre
                countrys = loadedFilter.country
                minYear = loadedFilter.minYear
                maxYear = loadedFilter.maxYear
                minRating = loadedFilter.minRating
                maxRating = loadedFilter.maxRating
                hideViewing = loadedFilter.hideViewing
            }
        }
    }
}


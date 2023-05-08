//
//  CustomListViewViewModel.swift
//  Zenion
//
//  Created by macbook on 30.04.23.
//

import SwiftUI
class CustomListViewViewModel: ObservableObject {
    @Published var filtermovies = [movie]()
    @Published var movies = [movie]()
    @Published  var ishide = Bool()
    let defaults = UserDefaults.standard
    var historyMovies = [movie]()
    init(Movie:[movie]){
        self.movies = Movie
        if filtermovies.isEmpty{
            filtermovies = Movie
        }
        history()
    }
    func history(){
        NotificationCenter.default.addObserver(self, selector: #selector(MovieNotification(_:)), name:Notification.Name("History"), object: nil)
        startFilter()
    }
    func startFilter(){
        ishide = false
        if let savedFilter = defaults.object(forKey: "filterMovies") as? Data {
            let decoder = JSONDecoder()
            if let loadedFilter = try? decoder.decode(filterMovies.self, from: savedFilter) {
                ishide = true
             filtermovies = []
                for movie in movies {
                    // type all
                    if loadedFilter.type == 0{
                        genreFilter(movie: movie, loadedFilter: loadedFilter)
                    }
                    //type movie
                    else if loadedFilter.type == 1{
                        if movie.video.count <= 1 {
                            genreFilter(movie: movie, loadedFilter: loadedFilter)
                        }
                    }
                    //type tv show
                    else{
                        if movie.video.count > 1{
                            genreFilter(movie: movie, loadedFilter: loadedFilter)
                        }
                    }
                }
            }
        }
    }
    @objc func MovieNotification(_ notification: Notification) {
        guard let history = notification.object as? [SaveHistory], !history.isEmpty else { return }

        historyMovies = []
        for savedHistory in history {
            if let movie = movies.first(where: { $0.name == savedHistory.MovieName }) {
                historyMovies.append(movie)
            }
        }
    }
    func genreFilter(movie:movie,loadedFilter:filterMovies){
        // genre
        if loadedFilter.genre == "All"{
            // contry
            contryFilter(movie: movie, loadedFilter: loadedFilter)
        }
        // genre else
        else{
            for moviGenre in movie.genre{
                if moviGenre == loadedFilter.genre{
                    contryFilter(movie: movie, loadedFilter: loadedFilter)
                }
            }
        }
    }

    func contryFilter(movie:movie,loadedFilter:filterMovies){
            // contry
            if loadedFilter.country == "All"{
                   lastFilter(movie: movie, loadedFilter: loadedFilter)
            }
            // contry else
          else{
              for movieCantry in movie.location{
                  if movieCantry == loadedFilter.country{
                      lastFilter(movie: movie, loadedFilter: loadedFilter)
                }
              }
        }
    }
    func lastFilter(movie:movie,loadedFilter:filterMovies){
        //rating
            if movie.star >= loadedFilter.minRating && movie.star <= loadedFilter.maxRating{
                //years
                if movie.years >= loadedFilter.minYear && movie.years <= loadedFilter.maxYear{
                  //hide viewing
                    if loadedFilter.hideViewing{
                        hideViewingFilter(movie: movie, loadedFilter: loadedFilter)
                    }
                    else{
                        filtermovies.append(movie)
                    }
               }
          }
     }
    func hideViewingFilter(movie:movie,loadedFilter:filterMovies){
        for historyMovie in historyMovies {
                if movie.name != historyMovie.name{
                    filtermovies.append(movie)
            }
        }
    }
}



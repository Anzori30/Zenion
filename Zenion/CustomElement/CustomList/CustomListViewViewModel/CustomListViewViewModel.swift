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
                    if movie.star >= loadedFilter.minRating && movie.star
                        <= loadedFilter.maxRating{
                        filtermovies.append(movie)
                    }
                    
                }
            }
        }
    }
    @objc func MovieNotification(_ notification: Notification) {
        guard let history = notification.object as? [SaveHistory], !history.isEmpty else { return }

        historyMovies = []
        for savedHistory in history {
            if savedHistory.fullTime <= savedHistory.endTime,
               let movie = movies.first(where: { $0.name == savedHistory.MovieName }) {
                historyMovies.append(movie)
            }
        }
        
    }}

//struct filterMovies:Encodable,Decodable{
//    let type:Int
//    let genre : [String]
//    let country :[ String]
//    let minYear: Int
//    let maxYear: Int
//    let minRating: Double
//    let maxRating: Double
//    let hideViewing:Bool
//}

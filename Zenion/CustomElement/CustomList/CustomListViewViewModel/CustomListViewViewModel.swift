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
    var historyMovies = [SaveHistory]()
    init(Movie:[movie],History:[SaveHistory]){
        self.movies = Movie
        self.historyMovies = History
        if filtermovies.isEmpty{
//        filtermovies = Movie
        }
        self.startFilter()
    }
    
    func startFilter(){
        if let savedFilter = defaults.object(forKey: "filterMovies") as? Data {
            let decoder = JSONDecoder()
            if let loadedFilter = try? decoder.decode(filterMovies.self, from: savedFilter) {
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
        if !historyMovies.contains(where: { $0.MovieName == movie.name }) {
                filtermovies.append(movie)
        }
    }
}



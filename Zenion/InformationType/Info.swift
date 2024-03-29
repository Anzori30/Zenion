//
//  Info.swift
//  Travel(app)
//
//  Created by anzori  on 2/18/23.
//  Copyright © 2023 anzori . All rights reserved.
//

import SwiftUI
struct UserPage {
    let destination: AnyView
    let name: String
    let navigationDisabled : Bool
    let action: () -> Void
}
struct MovieVideo:Hashable{
    let name: String
    let photo: String
    let video: [String]
}
struct filterMovies:Encodable,Decodable{
    let type:Int
    let genre : String
    let country : String
    let minYear: Int
    let maxYear: Int
    let minRating: Double
    let maxRating: Double
    let hideViewing:Bool
}
struct saveFavorite{
    let MovieName: String
}
struct SaveHistory{
    let MovieName: String
    let fullTime:Double
    let endTime:Double
}
struct movie: Hashable, Equatable {
    let name: String
    let photo: String
    let location: [String]
    let description: String
    let genre: [String]
    let director: String
    let video: [String]
    let trailer: String
    let star: Double
    let actors: [String]
    var favorite: Bool
    var years: Int
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(photo)
        hasher.combine(location)
        hasher.combine(description)
        hasher.combine(genre)
        hasher.combine(director)
        hasher.combine(video)
        hasher.combine(star)
        hasher.combine(actors)
        hasher.combine(favorite)
        hasher.combine(years)
        hasher.combine(trailer)
    }
}


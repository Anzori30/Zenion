//
//  Info.swift
//  Travel(app)
//
//  Created by anzori  on 2/18/23.
//  Copyright © 2023 anzori . All rights reserved.
//

import SwiftUI

struct UserPage {
    var destination: AnyView
    var name: String
}
struct MovieVideo:Hashable{
    let name: String
    let photo: String
    let video: [String]
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
    let location: String
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


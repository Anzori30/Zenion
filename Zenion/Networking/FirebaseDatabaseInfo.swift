//
//  FirebaseDatabaseInfo1.swift
//  Zenion
//
//  Created by macbook on 15.04.23.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

class FirebaseDatabaseInfo {
    var numb = 0
    var movies = [movie]()
    init(){
        startHTTP()
    }
    func startHTTP() {
        let db = Firestore.firestore()

        db.collection("Movies").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let actors = data["actors"] as? [String] ?? []
                    let description = data["description"] as? String ?? ""
                    let director = data["director"] as? String ?? ""
                    let genre = data["genre"] as? [String] ?? []
                    let location = data["location"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let video = data["video"] as? [String] ?? []
                    let trailer = data["trailer"] as? String ?? ""
                    let photo = data["photo"] as? String ?? ""
                    let star = data["star"] as? Double ?? 0.0
                    let years = data["years"] as? Int ?? 0
                    self.movies.append(movie(name: name, photo: photo, location: location, description: description, genre: genre, director: director, video: video, trailer: trailer, star: star, actors: actors, favorite: false, years: years))
                }
                if self.numb == 0 {
                    self.numb = 1
                    self.sendinfo()
                }
                
            }
        }
    }

    func sendinfo() {
        let notification = Notification(name: Notification.Name("MovieNotification"), object: self.movies, userInfo: nil)
        NotificationCenter.default.post(notification)
    }

}

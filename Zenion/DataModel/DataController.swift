//
//  DataController.swift
//  Zenion
//
//  Created by macbook on 24.04.23.
//

import Foundation
import CoreData
import SwiftUI
class DataController: ObservableObject {
    var movieNames = [String]()
    let container: NSPersistentContainer
    init() {
        container = NSPersistentContainer(name: "MovieModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
    }
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error.localizedDescription)")
        }
    }
    func addFavorite(movieNames: [String], context: NSManagedObjectContext) {
        for movieName in movieNames {
            let request: NSFetchRequest<FavoriteData> = FavoriteData.fetchRequest()
            request.predicate = NSPredicate(format: "movieName == %@", movieName)
            do {
                let matchingFavorites = try context.fetch(request)
                if matchingFavorites.isEmpty {
                    let favorite = FavoriteData(context: context)
                    favorite.movieName = movieName
                } else {
                    print("Favorite with name \(movieName) already exists, skipping...")
                }
            } catch {
                print("Failed to fetch favorites: \(error.localizedDescription)")
            }
        }
        save(context: context)
    }
    func printAllFavorites(context: NSManagedObjectContext) {
        let request: NSFetchRequest<FavoriteData> = FavoriteData.fetchRequest()
        do {
            let favorites = try context.fetch(request)
             movieNames = []
            for favorite in favorites {
                if let movieName = favorite.movieName {
                    movieNames.append( movieName)
                }
            }
            let notification = Notification(name: Notification.Name("Favorite"), object: movieNames, userInfo: nil)
            NotificationCenter.default.post(notification)
            print("All movie names: \(movieNames)")
        } catch {
            print("Failed to fetch favorites: \(error.localizedDescription)")
        }
    }
    func removeFavorites(movieNames: [String], context: NSManagedObjectContext) {
        let request: NSFetchRequest<FavoriteData> = FavoriteData.fetchRequest()
        request.predicate = NSPredicate(format: "movieName IN %@", movieNames)
        do {
            let favorites = try context.fetch(request)
            for favorite in favorites {
                context.delete(favorite)
            }
            save(context: context)
            print("Removed favorites with names: \(movieNames)")
        } catch {
            print("Failed to fetch favorites: \(error.localizedDescription)")
        }
    }
}

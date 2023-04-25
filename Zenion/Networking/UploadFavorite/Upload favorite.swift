//
//  Upload favorite.swift
//  Zenion
//
//  Created by macbook on 25.04.23.
//



import Firebase
import FirebaseDatabase
import FirebaseFirestore
class Uploadfavorite: ObservableObject {
    var movieNames = [String]()
    let db = Firestore.firestore()
    func addFavorite(movieNames: [String]) {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User is not authenticated")
            return
        }
        for movieName in movieNames {
            let docRef = db.collection("users").document(uid).collection("favorites").document(movieName)
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
//                    print("Favorite with name \(movieName) already exists, skipping...")
                } else {
                    self.db.collection("users").document(uid).collection("favorites").document(movieName).setData([
                        "movieName": movieName
                    ]) { err in
                        if let err = err {
                            print("Error adding favorite: \(err)")
                        } else {
//                            print("Favorite added with name: \(movieName)")
                        }
                    }
                }
            }
        }
    }
    
    func printAllFavorites() {
        self.movieNames = []
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User is not authenticated")
            return
        }
        db.collection("users").document(uid).collection("favorites").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching favorites: \(error)")
            } else {
                
                for document in querySnapshot!.documents {
                    let movieName = document.data()["movieName"] as? String ?? ""
                    self.movieNames.append(movieName)
                }
                let notification = Notification(name: Notification.Name("Favorite"), object: self.movieNames, userInfo: nil)
                NotificationCenter.default.post(notification)
            }
        }
    }
    
    func removeFavorites(movieNames: [String]) {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User is not authenticated")
            return
        }
        for movieName in movieNames {
            let docRef = db.collection("users").document(uid).collection("favorites").document(movieName)
            docRef.delete { (error) in
                if let error = error {
                    print("Error removing favorite: \(error)")
                } else {
                    self.printAllFavorites()
                }
            }
        }
    }
}

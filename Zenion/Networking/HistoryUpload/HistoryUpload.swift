//
//  HistoryUpload.swift
//  Zenion
//
//  Created by macbook on 27.04.23.
//

import Firebase
import FirebaseFirestore

class HistoryUpload: ObservableObject {
    var History = [SaveHistory]()
    let db = Firestore.firestore()

    func saveHistoryToFirestore(history: SaveHistory) {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User is not authenticated")
            return
        }

        let docRef = db.collection("users").document(uid).collection("History").document(history.MovieName)
        docRef.setData([
            "movieName": history.MovieName,
            "fullTime": history.fullTime,
            "endTime": history.endTime
        ]) { error in
            if let error = error {
                print("Error saving history: \(error)")
            } else {
                print("History saved successfully")
            }
        }
    }

    func printAllHistory() {
        self.History = []
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User is not authenticated")
            return
        }
        db.collection("users").document(uid).collection("History").getDocuments{(querySnapshot, error) in
            if let error = error {
                print("Error fetching favorites: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    let movieName = document.data()["movieName"] as? String ?? ""
                    let fullTime = document.data()["fullTime"] as? Double ?? 0.0
                    let endTime = document.data()["endTime"] as? Double ?? 0.0
                    let history = SaveHistory(MovieName: movieName, fullTime: fullTime, endTime: endTime)
                    self.History.append(history)
                }
                let notification = Notification(name: Notification.Name("History"), object: self.History, userInfo: nil)
                NotificationCenter.default.post(notification)
            }
        }
    }

    func removeHistory(movieNames: [String]) {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User is not authenticated")
            return
        }
        for movieName in movieNames {
            let docRef = db.collection("users").document(uid).collection("history").document(movieName)
            docRef.delete { (error) in
                if let error = error {
                    print("Error removing favorite: \(error)")
                } else {
                    self.printAllHistory()
                }
            }
        }
    }
}


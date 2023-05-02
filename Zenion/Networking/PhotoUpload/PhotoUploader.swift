//
//  PhotoUploader.swift
//  Zenion
//
//  Created by macbook on 19.04.23.
//

import SwiftUI
import Firebase
import FirebaseStorage
class PhotoUploader: ObservableObject {
    var imageUrl = String()
    let db = Firestore.firestore()
    let storage = Storage.storage()
    var documentId: String?

    func uploadPhoto(image: UIImage) {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User is not authenticated")
            return
        }

        let docRef = db.collection("users").document(uid).collection("Userimage").document("link")
        let imageData = image.jpegData(compressionQuality: 0.5)!
        let storageRef = storage.reference().child("images/\(uid).jpg")

        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
            } else {
                storageRef.downloadURL { url, error in
                    if let error = error {
                        print("Error getting download URL: \(error.localizedDescription)")
                    } else {
                        let imageURL = url!.absoluteString
                        docRef.setData([
                            "imageURL": imageURL
                        ]) { error in
                            if let error = error {
                                print("Error saving history: \(error)")
                            } else {
                                print("Image saved successfully")
                                self.documentId = docRef.documentID
                                self.imageLink()
                            }
                        }
                    }
                }
            }
        }
    }

    func imageLink() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User is not authenticated")
            return
        }
        db.collection("users").document(uid).collection("Userimage").getDocuments { querySnapshot, error in
            if let error = error {
                print("Error fetching image: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    let imageURL = document.data()["imageURL"] as? String ?? ""
                        self.imageUrl = imageURL
                }
                let notification = Notification(name: Notification.Name("UploadPhoto"), object: self.imageUrl, userInfo: nil)
                NotificationCenter.default.post(notification)
            }
        }
    }
}

//
//  ProfilePageViewModel.swift
//  Zenion
//
//  Created by macbook on 02.05.23.
//

import SwiftUI

class ProfilePageViewModel: ObservableObject {
  @Published var indicator = false
  @Published  var imageUrl = String()
    
    init() {
        takeLInk()
    }
    func takeLInk(){
        PhotoUploader().imageLink()
        NotificationCenter.default.addObserver(self, selector: #selector(handleMovieNotification(_:)), name: Notification.Name("UploadPhoto"), object: nil)
    }
    
    @objc func handleMovieNotification(_ notification: Notification) {
        imageUrl = ""
        if let URL = notification.object as? String, !URL.isEmpty {
              imageUrl = URL
           DispatchQueue.main.asyncAfter(deadline: .now() + 4){
                self.indicator = false
            }
        }
        else{
            imageUrl = "https://firebasestorage.googleapis.com/v0/b/zenion-19e7e.appspot.com/o/images%2FBaseImage%2Fdownload.png?alt=media&token=b9cd0b63-db6b-47b9-9032-6ed037c27b85"
        }
    }
}

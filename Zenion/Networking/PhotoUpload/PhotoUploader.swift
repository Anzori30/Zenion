//
//  PhotoUploader.swift
//  Zenion
//
//  Created by macbook on 19.04.23.
//

import SwiftUI
import Firebase
import FirebaseStorage

class PhotoUploader {
    
    func uploadProfilePicture(email: String, image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(UploadError.invalidImageData))
            return
        }
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let imageRef = storageReference.child("profile_pictures/\(email).jpg")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        imageRef.putData(imageData, metadata: metadata) { (metadata, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            imageRef.downloadURL { (url, error) in
                if let error = error {
                    completion(.failure(error))
                } else if let url = url {
                    completion(.success(url))
                } else {
                    completion(.failure(UploadError.unknown))
                }
            }
        }
    }

    enum UploadError: Error {
        case invalidImageData
        case unknown
    }
}

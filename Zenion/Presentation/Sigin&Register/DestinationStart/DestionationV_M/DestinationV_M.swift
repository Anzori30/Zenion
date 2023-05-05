//
//  DestinationV_M.swift
//  Zenion
//
//  Created by macbook on 05.05.23.
//

import SwiftUI
import Firebase
import AuthenticationServices
import GoogleSignIn

class DestinationV_M: NSObject, ObservableObject, ASAuthorizationControllerDelegate  {
   @Published var isGoogleSignIn = false
    @Published var isAppleSignIn = false

    let defaults = UserDefaults.standard

    @MainActor func googleAuth(){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: Utilities.topViewController()!) { [unowned self] result, error in
          guard error == nil else {
            return
          }
          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
            return
          }
          let credential = GoogleAuthProvider.credential(withIDToken: idToken,accessToken: user.accessToken.tokenString)
            if let profile = user.profile {
                Auth.auth().signIn(with: credential) { result, error in
                    if let error = error {
                        print(error.localizedDescription)
                    return
                    }
                    if let additionalUserInfo = result?.additionalUserInfo,additionalUserInfo.isNewUser {
                        if let url = URL(string: profile.imageURL(withDimension: 200)!.absoluteString) {
                            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                                guard let data = data, error == nil else {
                                    // handle error
                                    return
                                }
                                DispatchQueue.main.async {
                                    let image = UIImage(data: data)
                                    PhotoUploader().uploadPhoto(image: image!)
                                }
                            }
                            task.resume()
                        }
                    }
                    self.isGoogleSignIn = true
                    self.defaults.set(self.isGoogleSignIn, forKey: "isLogined")
                    self.defaults.set(profile.name, forKey: "Name")
                    self.defaults.set(profile.email, forKey: "Email")
                  }
                }
            }
        }
    
    
    
    func appleAuth() {
           let appleIDProvider = ASAuthorizationAppleIDProvider()
           let request = appleIDProvider.createRequest()
           request.requestedScopes = [.fullName, .email]
           let controller = ASAuthorizationController(authorizationRequests: [request])
           controller.delegate = self
           controller.performRequests()
       }
       
       func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
           switch authorization.credential {
           case let appleIDCredential as ASAuthorizationAppleIDCredential:
               guard let appleIDToken = appleIDCredential.identityToken else {
                   print("Unable to fetch identity token")
                   return
               }
               guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                   print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                   return
               }
               let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: "")
               Auth.auth().signIn(with: credential) { authResult, error in
                   if let error = error {
                       print(error.localizedDescription)
                       return
                   }
                   self.isAppleSignIn = true
               }
           default:
               break
           }
       }
       
       func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
           print("Apple authentication error: \(error.localizedDescription)")
       }
    
    }


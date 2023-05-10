//
//  SettingViewModel.swift
//  Zenion
//
//  Created by macbook on 10.05.23.
//


import SwiftUI
import Firebase
import GoogleSignIn
class SettingViewModel:ObservableObject{
    let defaults = UserDefaults.standard
      var hideView = Bool()
    @Published var ActivityIndicator = Bool()
    init() {
        let isUserLogginedIn = UserDefaults.standard.bool(forKey: "hidenViewing")
        hideView = isUserLogginedIn
    }
    func clearHistory(){
        ActivityIndicator = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            UserHistory().clearHistory()
            self.ActivityIndicator = false
        }
    }
    func hidenViewing(Hide:Bool){
        self.defaults.set(Hide, forKey: "hidenViewing")
    }
}

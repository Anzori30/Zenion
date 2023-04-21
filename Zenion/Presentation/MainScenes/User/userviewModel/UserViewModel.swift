//
//  UserViewModel.swift
//  Zenion
//
//  Created by macbook on 19.04.23.
//

import SwiftUI

class UserViewModel:ObservableObject{
 @Published var ActivityIndicator = false
    var valueToSave = Bool()
    let userName = UserDefaults.standard.string(forKey: "userName") ?? "Unknown"
    let userEmail = UserDefaults.standard.string(forKey: "userEmail") ?? "Unknown"
    let defaults = UserDefaults.standard
   
    func logOut(){
        ActivityIndicator = true
        self.valueToSave = false
        self.defaults.set(self.valueToSave, forKey: "isLogined")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            NotificationCenter.default.post(name: NSNotification.Name("LogOut"), object: nil)
        }
    }
}

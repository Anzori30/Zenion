//
//  ProfilePhoto.swift
//  Zenion
//
//  Created by macbook on 25.04.23.
//

import SwiftUI
 struct ProfilePhoto: View {
    var name:String
    var email:String
    var body: some View {
        NavigationLink( destination: FavoriteView()){
            VStack{
                Image("test")
                    .resizable()
                    .frame(width: 130,height: 130)
                    .cornerRadius(100)
                Text(name)
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                Text(email)
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundColor(.gray)
            }
        }
    }
}

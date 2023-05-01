//
//  ProfilePhoto.swift
//  Zenion
//
//  Created by macbook on 25.04.23.
//

import SwiftUI
import Kingfisher
 struct ProfilePhoto: View {
    var name:String
    var email:String
     var imageUrl:String
    var body: some View {
        NavigationLink( destination: ProfilePageView(imageLink: imageUrl, name: name, email: email)){
            VStack{
                KFImage(URL(string: imageUrl))
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

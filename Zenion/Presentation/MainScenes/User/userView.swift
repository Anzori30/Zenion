//
//  userView.swift
//  Zenion
//
//  Created by macbook on 05.04.23.
//

import SwiftUI


struct userView: View {
    @StateObject var viewModel = UserViewModel()
    var body: some View {
        ZStack {
            Color("Dark")
                .ignoresSafeArea()
            VStack {
                Spacer()
                ProfilePhoto(name: viewModel.userName, email: viewModel.userEmail)
                Spacer()
                ScrollViewList(info:
                                [
                                    UserPage(destination: AnyView(FavoriteView()), name: "Profile"),
                                    UserPage(destination: AnyView(FavoriteView()), name: "Subscription"),
                                    UserPage(destination: AnyView(FavoriteView()), name: "Setting"),
                                    UserPage(destination: AnyView(FavoriteView()), name: "Downloads"),
                                    UserPage(destination: AnyView(FavoriteView()), name: "Promocodes"),
                                    UserPage(destination: AnyView(FavoriteView()), name: "Support"),
                                ])
                Spacer()
                Button(action: {
                    viewModel.logOut()
                },
                label: {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.forward")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                        Text("Log out")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                    }
                })
                Spacer()
            }
            .padding([.leading,.trailing],10)
        } .overlay(
            HStack{
                if viewModel.ActivityIndicator {
                    Zenion.ActivityIndicator(isAnimating: true)
                        .foregroundColor(.red)
                        .frame(width: 80)
            }
        })
    }
}

struct userView_Previews: PreviewProvider {
    static var previews: some View {
        userView()
    }
}


fileprivate struct ProfilePhoto: View {
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


fileprivate struct ScrollViewList: View {
    var info = [UserPage]()
    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                ForEach(info, id: \.name) { page in
                    NavigationLink(destination: page.destination) {
                        HStack {
                            Text(page.name)
                                .font(.system(size: 17, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                            Spacer()
                            Image(systemName: "arrow.right")
                                .foregroundColor(.gray)
                                .frame(width: 17, height: 17)
                        }
                    }
                    .padding([.leading, .trailing], 20)
                    .frame(height: 50)
                    .background(Color("Gray"))
                    .cornerRadius(20)
                }
            }
        }
        .frame(height: CGFloat(info.count) * 60)
    }
}

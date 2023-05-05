//
//  userView.swift
//  Zenion
//
//  Created by macbook on 05.04.23.
//

import SwiftUI


struct UserView: View {
    @StateObject var viewModel = UserViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                Color("Dark")
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    if viewModel.restart{
                        ProfilePhoto(name: viewModel.userName, email: viewModel.userEmail, imageUrl: viewModel.imageUrl)
                    }
                    Spacer()
                    UserSclorLIstView(info:
                                        [
                                            UserPage(destination: AnyView(ProfilePageView(imageLink: viewModel.imageUrl, name: viewModel.userName, email: viewModel.userEmail)), name: "Profile"),
                                            UserPage(destination: AnyView(FavoriteView()), name: "Subscription"),
                                            UserPage(destination: AnyView(FavoriteView()), name: "Setting"),
                                            UserPage(destination: AnyView(FavoriteView()), name: "Downloads"),
                                            UserPage(destination: AnyView(AllMovieView(movies: viewModel.historyMovies, title: "History")), name: "History"),
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
            }
            .overlay(
                HStack{
                    if viewModel.ActivityIndicator {
                        Zenion.ActivityIndicator(isAnimating: true)
                            .foregroundColor(.red)
                            .frame(width: 80)
                    }
                })
            .onAppear{
                viewModel.takeLink()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}







struct userView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}






//
//  HomeView.swift
//  Zenion
//
//  Created by macbook on 05.04.23.
//

import SwiftUI
import Kingfisher
struct HomeView: View {
    @StateObject var viewModel = HomeModelView()
    

    var body: some View {
        ZStack {
            Color("Dark")
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: 50) {
                    if viewModel.showMovies {
                        imageTableView(movies: viewModel.Homemovies, height:Int(UIScreen.main.bounds.width) )
                            Contents(headerText: "Continue viewing", movies:viewModel.Homemovies,width: 280,height: 260)
                            Contents(headerText: "Top Movie", movies: viewModel.Homemovies,width: 200,height: 300)
                            Contents(headerText: "Top Movie", movies: viewModel.Homemovies,width: 200,height: 300)
                            Contents(headerText: "premiere", movies: viewModel.Homemovies,width: 200,height: 300)
                        Spacer()
                    }
                }
            }
        }  .overlay(
            HStack{
                if viewModel.ActivityIndicator {
                   ActivityIndicator(isAnimating: true)
                    .foregroundColor(.red)
                    .frame(width: 80)
               }
        })
    }
}




struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
struct imageTableView: View {
    var movies: [movie]
    let height:Int
    var body: some View {
                TabView {
                    ForEach(movies, id: \.self) { movie in
                        KFImage(URL(string: movie.photo))
                         .resizable()
                    }
                }
                .frame(height: CGFloat(Double(height) / 1.2 ))
                .cornerRadius(20)
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .padding([.leading,.trailing])
    }
}

struct Contents: View {
    let headerText:String
    var movies: [movie]
    let width:Int
    let height:Int
    var body: some View {
        VStack{
            HStack{
                Text(headerText)
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding([.leading],20)
                Spacer()
                NavigationLink(destination: FavoriteView()){
                    Text("see More")
                    .padding([.trailing],20)
                    .font(.system(size: 14, weight: .bold ))
                }

            }
            ScrollView(.horizontal) {
                HStack {
                    ForEach(movies, id: \.self) { movie in
                        Button {
                            //action
                            print(movie.actors)
                        }
                      label: {
                        VStack{
                            KFImage(URL(string: movie.photo))
                                   .resizable()
                                   .frame(width: CGFloat(width), height: CGFloat(height - 50))
                                   .cornerRadius(30)
                            Text(movie.name)
                                   .font(.system(size: 20, weight: .bold, design: .rounded))
                                   .foregroundColor(.white)
                                   .frame(height:50)
                        }
                        .frame(width: CGFloat(width),height: CGFloat(height + 20))
                     }
                        
                    }
                    
                }
            }
            .scrollIndicators(.hidden)
        }
        
    }
}

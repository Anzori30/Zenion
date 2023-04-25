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
    @State private var width = CGFloat(Int(UIScreen.main.bounds.width))
    @State private var height = CGFloat(Int(UIScreen.main.bounds.height))
    var body: some View {
        NavigationView{
            ZStack {
                Color("Dark")
                    .ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 50) {
                        if viewModel.showMovies {
                            HomeimageTableView(movies: viewModel.Homemovies, height:Int(width) )
                            HomeContents(headerText: "Continue viewing", movies:viewModel.Homemovies,width: width / 1.8 ,height :height / 3.6 )
                            HomeContents(headerText: "Top Movie", movies: viewModel.Homemovies,width: width / 2.5 ,height :height / 3.3 )
                            HomeContents(headerText: "Top Movie", movies: viewModel.Homemovies,width: width / 2.5 ,height :height / 3.3 )
                            HomeContents(headerText: "premiere", movies: viewModel.Homemovies,width: width / 2.5 ,height :height / 3.3 )
                            Spacer()
                        }
                    }
                }
            }
        }
        .overlay(
           HStack{
               if viewModel.ActivityIndicator {
                   ActivityIndicator(isAnimating: true)
                       .foregroundColor(.red)
                       .frame(width: 80)
               }
           })
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}



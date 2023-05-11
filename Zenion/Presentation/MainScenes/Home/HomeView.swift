//
//  HomeView.swift
//  Zenion
//
//  Created by macbook on 05.04.23.
//

import SwiftUI
import Kingfisher
struct HomeView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
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
                            
                            HomeimageTableView(movies: viewModel.banerMovies, height:Int(width) )
                            if !viewModel.historyMovies.isEmpty && viewModel.hideView{
                              HomeContents(headerText: "Continue viewing", movies:viewModel.historyMovies,width: width / 2.0 ,height :height / 3.6 )
                            }
                            HomeContents(headerText: "All Movie", movies: viewModel.Homemovies,width: width / 2.5 ,height :height / 3.3 )
                            HomeContents(headerText: "Top Movie", movies: viewModel.topMovie,width: width / 2.5 ,height :height / 3.3 )
                            HomeContents(headerText: "Trailer", movies: viewModel.trailer,width: width / 2.5 ,height :height / 3.3 )
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
        .onAppear{
            viewModel.history()
            viewModel.hidenViewing()
          
//            UserFavorite().printAllFavorites()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}



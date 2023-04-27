//
//  AllMovieView.swift
//  Zenion
//
//  Created by macbook on 05.04.23.
//

import SwiftUI

struct AllMovieView: View {
    var movies : [movie]
    var title:String
    @StateObject var viewModel = AllModelView()
    var body: some View {
            ZStack{
                Color("Dark")
                    .ignoresSafeArea()
                if movies.isEmpty{
                    CustomListView(headerText: "All", movies: viewModel.Movie , width: Int(UIScreen.main.bounds.width), height: Int(UIScreen.main.bounds.height) / 3)
                }
                else{
                    CustomListView(headerText: title, movies: movies , width: Int(UIScreen.main.bounds.width), height: Int(UIScreen.main.bounds.height) / 3)
                }
            }
            //zs end
            .overlay(
                HStack{
                    if viewModel.ActivityIndicator {
                        ActivityIndicator(isAnimating: true)
                            .foregroundColor(.red)
                            .frame(width: 80)
                }
            })
            .onAppear{
                HistoryUpload().printAllHistory()
            }
        
    }
    
}

struct AllMovieView_Previews: PreviewProvider {
    static var previews: some View {
        AllMovieView(movies: [], title:"All")
    }
}

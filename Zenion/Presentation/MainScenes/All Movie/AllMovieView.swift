//
//  AllMovieView.swift
//  Zenion
//
//  Created by macbook on 05.04.23.
//

import SwiftUI

struct AllMovieView: View {
    @StateObject var viewModel = AllModelView()
    var body: some View {
            ZStack{
                Color("Dark")
                    .ignoresSafeArea()
                CustomListView(headerText: "All", movies: viewModel.Homemovies, width: Int(UIScreen.main.bounds.width), height: Int(UIScreen.main.bounds.height) / 3)
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
    }
}

struct AllMovieView_Previews: PreviewProvider {
    static var previews: some View {
        AllMovieView()
    }
}

//
//  HomeimageTableView.swift
//  Zenion
//
//  Created by macbook on 22.04.23.
//

import SwiftUI
import Kingfisher
struct HomeimageTableView: View {
    var movies: [movie]
    let height:Int
    var body: some View {
                TabView {
                    ForEach(movies, id: \.self) { movie in
                        NavigationLink(destination: DetalPageView(movies: movie)){
                            KFImage(URL(string: movie.photo))
                                .resizable()
                        }
                    }
                }
                .frame(height: CGFloat(Double(height) / 1.2 ))
                .cornerRadius(20)
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .padding([.leading,.trailing])
    }
}

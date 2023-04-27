//
//  CustomListView.swift
//  Zenion
//
//  Created by macbook on 08.04.23.
//

import SwiftUI
import Swift
import Kingfisher
struct CustomListView: View {
    let headerText: String
    var movies: [movie]
    let width: Int
    let height: Int
    
    var body: some View {
        VStack{
            HStack {
                Text(headerText)
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding([.leading],20)
                Spacer()
                NavigationLink(destination: HomeView()) {
                    Image(systemName: "square.rightthird.inset.filled")
                        .frame(width: 30, height: 30)
                        .foregroundColor(.gray)
                }
                .padding([.trailing,.bottom],30)
            }
            .frame(height: 40)
            ScrollView {
                LazyVStack {
                    ForEach(movies, id: \.self) { movie in
                        NavigationLink(destination: DetalPageView(movies: movie) ){
                        HStack {
                            KFImage(URL(string: movie.photo))
                                .resizable()
                                .frame(width: CGFloat(width / 2), height: CGFloat(height))
                                .cornerRadius(30)
                            VStack(alignment: .leading, spacing: 10) {
                                Text(movie.name)
                                    .font(.system(size: 15, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                HStack {
                                    Text(String(format: "%.1f", movie.star))
                                        .font(.system(size: 15, weight: .bold, design: .rounded))
                                        .foregroundColor(.white)
                                    Image(systemName: "star.fill")
                                        .resizable()
                                        .foregroundColor(.purple)
                                        .frame(width: 15, height: 15)
                                    Spacer()
                                }
                                 
                                Text("\(String(movie.years)) \(movie.location)")
                                    .font(.system(size: 15, weight: .bold, design: .rounded))
                                    .foregroundColor(Color("textColor"))
                                Text(movie.genre.joined(separator: ", "))
                                    .font(.system(size: 15, weight: .bold, design: .rounded))
                                    .foregroundColor(Color("textColor"))
                                Text(movie.description)
                                    .font(.system(size: 15))
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                            .frame(height: CGFloat(height))
                            .padding([.leading,],0)
                          }
                        }
                        .listRowBackground(Color.clear)
                    }
                }
                .padding([.bottom],150)
            }
            .cornerRadius(30)
            .padding([.bottom,],-100)
            .padding([.leading,.trailing,],7)
        }
    }
}

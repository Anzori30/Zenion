//
//  HomeContents.swift
//  Zenion
//
//  Created by macbook on 22.04.23.
//

import SwiftUI
import Kingfisher
struct HomeContents: View {
    let headerText:String
    var movies: [movie]
    let width:CGFloat
    let height:CGFloat
    var body: some View {
        if !movies.isEmpty{
            VStack{
                HStack{
                    Text(headerText)
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .padding([.leading],20)
                    Spacer()
                    NavigationLink(destination: AllMovieView(movies: movies, title: headerText, seeAll: true)){
                        Text("see More")
                            .padding([.trailing],20)
                            .font(.system(size: 14, weight: .bold ))
                    }
                }
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(movies, id: \.self) { movie in
                            NavigationLink(destination: DetalPageView(movies: movie) ){
                                VStack{
                                    ShimerAnimation(url: movie.photo)
                                        .frame(width: width, height:height - 50)
                                        .cornerRadius(30)
                                    Text(movie.name)
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                        .foregroundColor(.white)
                                        .frame(height:50)
                                }
                                .frame(width: width,height: height + 20)
                            }
                            
                        }
                        
                    }
                }
                .padding([.leading],5)
                .scrollIndicators(.hidden)
            }
            
        }
    }
}


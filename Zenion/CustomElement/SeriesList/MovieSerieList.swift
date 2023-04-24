//
//  MovieSerieLIst.swift
//  Zenion
//
//  Created by macbook on 23.04.23.
//

import SwiftUI
import Kingfisher
struct MovieSerieList: View {
    let headerText: String
    var movies: MovieVideo
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        VStack {
            HStack {
                Text(headerText)
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding([.leading], 20)
                Spacer()
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(Array(movies.video.enumerated()), id: \.element) { index, video in
                        NavigationLink(destination: VideoPlayerView(videoLink: movies.video[index])) {
                            VStack {
                                KFImage(URL(string: movies.photo))
                                    .resizable()
                                    .frame(width: width, height: height - 50)
                                    .cornerRadius(30)
                                Text("S\(index + 1)")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                    .frame(height: 50)
                            }
                            .frame(width: width, height: height + 20)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}


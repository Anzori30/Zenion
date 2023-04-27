//
//  HomeimageTableView.swift
//  Zenion
//
//  Created by macbook on 22.04.23.
//

import SwiftUI
import Kingfisher
import Kingfisher
import SwiftUI

struct HomeimageTableView: View {
    var movies: [movie]
    let height: Int
    @State private var selectedMovie: movie?
    @State private var showIndicator: Bool = true // add state variable for indicator
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(movies.indices, id: \.self) { index in
                        NavigationLink(destination: DetalPageView(movies: movies[index])) {
                            KFImage(URL(string: movies[index ].photo))
                                .resizable()
                                .frame(width: CGFloat(height) * 0.9, height: CGFloat(height))
                                .cornerRadius(20)
                                .shadow(radius: 5)
                        }
                        .onAppear {
                                withAnimation(.easeInOut(duration: 0.3)){
                                  selectedMovie = movies[index]
                              }
                           }
                        .padding([.trailing],40)
                    }
                }
                .padding([.leading, .trailing])
               .padding(.vertical, 20)
          }
            .background(
                HStack {
                    KFImage(URL(string: selectedMovie?.photo ?? ""))
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width + 20 , height: UIScreen.main.bounds.height * 0.9)
                        .scaledToFill()
                        .blur(radius: 10)
                    LinearGradient(
                        gradient: Gradient(colors: [Color.clear, Color("Dark")]),
                        startPoint: .center,
                        endPoint: .bottom
                 )
                }
                .edgesIgnoringSafeArea(.all)
            )
        }
    }
}

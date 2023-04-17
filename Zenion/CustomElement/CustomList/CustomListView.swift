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
                NavigationLink( destination: HomeView()){
                    Image(systemName: "square.rightthird.inset.filled")
                        .frame(width: 30,height: 30)
                        .foregroundColor(.gray)
                }
                .padding([.trailing,.bottom],30)
            }
      
            List {
                ForEach(movies, id: \.self) { movie in
                  
                    HStack{
                        KFImage(URL(string: movie.photo))
                           .resizable()
                           .frame(width: CGFloat(width / 2), height: CGFloat(height))
                           .cornerRadius(30)
                        VStack{
                            Text(movie.name)
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("\(movie.years)")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("movie.genre")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(movie.description)
                                .font(.system(size: 15))
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                        }
                        .frame(height: CGFloat(height))
                        .padding([.leading,],0)
                    }
                }
                .listRowBackground(Color.clear)
            }
            .padding([.bottom,],-100)
            .cornerRadius(40)
            .listStyle(PlainListStyle())
        }
    }
}

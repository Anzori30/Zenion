//
//  HomeView.swift
//  Zenion
//
//  Created by macbook on 05.04.23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        Color("Dark")
            .ignoresSafeArea()
            .overlay(
                ScrollView {
                    VStack(spacing: 50) {
                        imageTableView()
                        Contents(headerText: "Continue viewing",width: 270,height: 170)
                        Contents(headerText: "Top Movie",width: 200,height: 250)
                        Contents(headerText: "Top Movie",width: 200,height: 250)
                        Contents(headerText: "premiere",width: 200,height: 250)
                        Spacer()
                    }
                })
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
struct imageTableView: View {
    var body: some View {
                TabView {
                    Image("test")
                    Image("test")
                    Image("test")
                    Image("test")
                    }
                .cornerRadius(20)
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .padding([.leading,.trailing])
                .frame(height: 320)
    }
}

struct Contents: View {
    let headerText:String
    let images = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "image8", "image9", "image10"]
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
                NavigationLink(destination: FavoriteView()){
                    Text("see More")
                    .padding([.trailing],20)
                    .font(.system(size: 14, weight: .bold ))
                }

            }
            ScrollView(.horizontal) {
                HStack {
                    ForEach(images, id: \.self) { imageName in
                        VStack{
                            Image("test")
                                   .resizable()
                                   .frame(width: CGFloat(width), height: CGFloat(height))
                                   .cornerRadius(30)
                               Text("Continue viewogfh")
                                   .font(.system(size: 20, weight: .bold, design: .rounded))
                                   .foregroundColor(.white)
                        }
                        .frame(width: CGFloat(width))
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        
    }
}

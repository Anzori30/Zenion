//
//  DetalPageView.swift
//  Zenion
//
//  Created by macbook on 21.04.23.
//

import SwiftUI
import Kingfisher
struct DetalPageView: View {
    @State private var height = CGFloat(Int(UIScreen.main.bounds.height))
    @State private var width = CGFloat(Int(UIScreen.main.bounds.width))
    var movies: movie
    var body: some View {
        let playerView = YouTubePlayerView(videoLink: movies.trailer)
        ZStack{
                Color("Dark")
                    .ignoresSafeArea()
                
                ScrollView{
      
                        VStack{
                            menu(width: width, height: height, movies: movies)
                            DescriptionView(text: movies.description)
                                .padding([.leading,.trailing],20)
                            if movies.trailer != ""{
                                playerView
                                    .frame(width: width - 20, height: height / 2.5)
                                            .cornerRadius(20)
                                .onAppear {
                                        playerView.playVideo()
                                    }
                            }
                        }.padding([.bottom],100)
                }//scroll
                .ignoresSafeArea()
            }
        }
    }

struct DetalPageView_Previews: PreviewProvider {
    static var previews: some View {
        DetalPageView(movies: movie(name: "", photo: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPCXISA7AWonO3J24GKCgtJ9e4OTuaJHSBM7rcN3j28GfR6eJAJTe1Gi_AlJpG6wuFnCs&usqp=CAU", location: "sdffsafsf", description: "sdsfdfsf", genre: ["fdsfsf","sdasd"], director: "dsadfsdf", video: ["dsdsdsaddasd","SDsafdsfsdfs","dasdd"], trailer: "", star: 0.0, actors: [], favorite: true, years: 0))
    }
}




/// Mark menu
fileprivate struct menu: View {
    var width:CGFloat
    var height:CGFloat
    var movies: movie
    @State private var hiideSeries = true
    var body: some View {
        ZStack{
            KFImage(URL(string: movies.photo))
                          .resizable()
                          .frame(width: width ,height: height/2)
                      LinearGradient(
                          gradient: Gradient(colors: [Color.clear, Color("Dark")]),
                          startPoint: .center,
                          endPoint: .bottom
                )
        }
        VStack(alignment: .leading, spacing: 10) {
            Text(movies.name)
                .font(.system(size: 25, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            HStack {
                Text(String(format: "%.1f",movies.star))
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                Image(systemName: "star.fill")
                    .resizable()
                    .foregroundColor(.purple)
                    .frame(width: 15, height: 15)
                Spacer()
            }
            Text("\(String(movies.years)) \(movies.location)")
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .foregroundColor(Color("textColor"))
            Text(movies.genre.joined(separator: ", "))
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .foregroundColor(Color("textColor"))
            HStack{
                Button {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        guard hiideSeries else{
                            hiideSeries = true
                            return
                        }
                     hiideSeries = false
                    }
                } label: {
                 
                    Text("Watch")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                }
                .opacity(movies.video.isEmpty ? 0.5 : 1.0)
                .disabled(movies.video.isEmpty)
                .frame(width: 160,height: 40)
                .background(.purple)
                .cornerRadius(200)
                icon(imageName: "bookmark", spacer: true, height: 25)
                icon(imageName: "arrow.down.to.line", spacer: false, height: 25)
            }
            
            if !hiideSeries {
                let movieVideo = MovieVideo(name: movies.name, photo: movies.photo, video: movies.video)
                MovieSerieList(headerText: "Series", movies: movieVideo , width: width/3, height: height/4)
            }
         }
        .padding([.leading,.trailing],20)
    }
}

fileprivate struct icon: View {
    var imageName:String
    var spacer:Bool
    var height:Int
    var body: some View {
        Button {
           ///            "bookmark"
        } label: {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 20,height:CGFloat(height))
                .foregroundColor(Color("textColor"))
        }
        .padding([.leading,.trailing],50)
        .padding([.top],5)
        .frame(width: 30,height: 30)
        if spacer{
            Text("|")
              .font(.system(size: 25))
              .foregroundColor(.gray)
        }
        
    }
}





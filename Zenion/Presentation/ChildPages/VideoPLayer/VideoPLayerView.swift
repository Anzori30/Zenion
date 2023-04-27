//
//  VideoPLayerView.swift
//  Zenion
//
//  Created by macbook on 23.04.23.
//

import AVKit
import SwiftUI
import CoreData

struct VideoPlayerView: View {
    var movieName: String
    var videoLink: String
    @State private var width = CGFloat(Int(UIScreen.main.bounds.width))
    @State private var height = CGFloat(Int(UIScreen.main.bounds.height))
    @State private var isLoading = true
    @State private var endTimes = Double()
   @State private var fullTime = Double()
    var body: some View {
        if let url = URL(string: videoLink) {
            let player = AVPlayer(url: url)
            var observers = [Any]()
            ZStack {
                Player(player: player)
                    .frame(width: width, height: height)
                    .ignoresSafeArea()
                if isLoading {
                    ActivityIndicator(isAnimating: true)
                        .foregroundColor(.red)
                        .frame(width: 50)
                }
            }
            .onReceive(player.publisher(for: \.timeControlStatus)) { status in
                if status == .playing {
                    isLoading = false
                }
            }
            .onAppear {
                let observer = player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: DispatchQueue.main) { [weak player] time in
                    guard let player = player else {
                        return
                    }
                    print("Current time: \(time.seconds)")
                    fullTime = time.seconds
                    if let currentItem = player.currentItem {
                        endTimes = currentItem.asset.duration.seconds
                    }
                }
                observers.append(observer)
            }
            .onDisappear {
                if endTimes != 0.0  && fullTime != 0.0 {
                    HistoryUpload().removeHistory(movieNames: [movieName])
                    HistoryUpload().saveHistoryToFirestore(history: SaveHistory(MovieName: movieName, fullTime: fullTime, endTime: endTimes - 900 ))
                }
                
                
                player.replaceCurrentItem(with: nil)
                observers.removeAll()
            }
        }
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView(movieName: "", videoLink: "https://example.com/video.mp4")
    }
}




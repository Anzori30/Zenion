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
    var videoLink: String
    @State private var width = CGFloat(Int(UIScreen.main.bounds.width))
    @State private var height = CGFloat(Int(UIScreen.main.bounds.height))
    @State private var isLoading = true
    var body: some View {
        if let url = URL(string: videoLink) {
            let player = AVPlayer(url: url)
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
        }
    }
}
struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView(videoLink: "")
    }
}

struct Player: UIViewControllerRepresentable {
    let player: AVPlayer
    func makeUIViewController(context: UIViewControllerRepresentableContext<Player>) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        player.play()
        return controller
    }
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: UIViewControllerRepresentableContext<Player>) {
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        let parent: Player
        
        init(_ parent: Player) {
            self.parent = parent
            super.init()
                    NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: parent.player.currentItem)
        }
        
        deinit {
            NotificationCenter.default.removeObserver(self)
        }
        
        @objc func playerDidFinishPlaying(_ note: NSNotification) {
           
        }
    }
}

//
//  Player.swift
//  Zenion
//
//  Created by macbook on 27.04.23.
//

import SwiftUI
import AVKit

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

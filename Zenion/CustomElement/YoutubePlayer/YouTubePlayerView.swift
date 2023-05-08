//
//  YouTubePlayerView.swift
//  Zenion
//
//  Created by macbook on 21.04.23.
//

import SwiftUI
import YouTubeiOSPlayerHelper

struct YouTubePlayerView: UIViewRepresentable {
    let playerView = YTPlayerView()
    var videoLink: String
    func makeUIView(context: UIViewRepresentableContext<YouTubePlayerView>) -> YTPlayerView {
        return playerView
    }
    func updateUIView(_ uiView: YTPlayerView, context: UIViewRepresentableContext<YouTubePlayerView>) {
    }
    func playVideo() {
        let videoId = videoLink.youtubeID
        playerView.load(withVideoId: videoId)
    }
    static func dismantleUIView(_ uiView: YTPlayerView, coordinator: ()) {
        uiView.stopVideo()
    }
}
extension String {
    var youtubeID: String {
        let regexString = #"(?<=v=|v\/|vi=|vi\/|youtu\.be\/|\/embed\/)([^#\&\?\n]+)"#
        let regex = try! NSRegularExpression(pattern: regexString, options: .caseInsensitive)
        let range = NSRange(location: 0, length: self.count)
        let match = regex.firstMatch(in: self, options: [], range: range)
        let videoId = (match != nil) ? (self as NSString).substring(with: match!.range) : ""
        return videoId
    }
}


//
//  DowloadVideoView.swift
//  Zenion
//
//  Created by macbook on 05.05.23.
//



import SwiftUI
import AVKit
import UserNotifications



struct DowloadVideoView: View {
    @State private var downloadProgress: Float = 0.0
    @State private var isDownloading: Bool = false
    @State private var downloadURLString: String = ""

    var body: some View {
        VStack {
            TextField("Enter video URL", text: $downloadURLString)
                .padding()
            Button(action: startDownload) {
                Text("Download Video")
            }
            .padding()
            .disabled(isDownloading || downloadURLString.isEmpty)
            Spacer()
            if isDownloading {
               Text("\(downloadProgress)")
                    
            }
            Spacer()
        }
    }

    private func startDownload() {
        guard let url = URL(string: downloadURLString) else { return }
        isDownloading = true
        let task = URLSession.shared.downloadTask(with: url) { (tempURL, response, error) in
            guard let tempURL = tempURL else {
                self.isDownloading = false
                return
            }
            let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let destinationURL = documentsDirectoryURL.appendingPathComponent(url.lastPathComponent)
            do {
                try FileManager.default.moveItem(at: tempURL, to: destinationURL)
                self.isDownloading = false
                print("Downloaded video location: \(destinationURL)")
            } catch {
                print(error)
                self.isDownloading = false
            }
        }
        task.resume()
        var timer: Timer?
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            let progress = Float(task.countOfBytesReceived) / Float(task.countOfBytesExpectedToReceive)
            self.downloadProgress = progress
            if progress >= 1.0 {
                timer?.invalidate()
            }
        }
    }
}




struct DowloadVideoView_Previews: PreviewProvider {
    static var previews: some View {
        DowloadVideoView()
    }
}

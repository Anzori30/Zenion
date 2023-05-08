//
//  ShimerAnimation.swift
//  Zenion
//
//  Created by macbook on 08.05.23.
//

import SwiftUI
import Kingfisher
import Shimmer
struct ShimerAnimation: View {
    @State private var shimerStart = true
    var url : String
    var body: some View {
        KFImage(URL(string: url))
            .placeholder {
                // Placeholder while downloading.
            }
            .retry(maxCount: 5, interval: .seconds(10))
            .onSuccess { r in
                // r: RetrieveImageResult
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                    shimerStart = false
//                }
            }
            .onFailure { e in
                // e: KingfisherError
            }
            .resizable()
            .redacted(reason: shimerStart ? .placeholder : .init())
            .shimmering(active: shimerStart)
    }
}
struct ShimerAnimation_Previews: PreviewProvider {
    static var previews: some View {
        ShimerAnimation(url: "")
    }
}

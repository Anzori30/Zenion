//
//  LaunchScreen.swift
//  Zenion
//
//  Created by macbook on 10.04.23.
//

import SwiftUI

struct LaunchScreen: View {
    @State private var destinationStart = false
    
    var body: some View {
        ZStack{
            GeometryReader { geo in
                Image("LaunchScreenImage")
                    .resizable()
                    .frame(width: geo.size.width, height: geo.size.height)
            }
            .ignoresSafeArea()
            
            SlowTextWithImage(text: "Z e n i o n", image: Image("logo"), imageIndex: 1)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    destinationStart = true
                }
            }
        }
        .fullScreenCover(isPresented: $destinationStart, content: {
            DestinationStart()
        })
    }
}


struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
struct SlowTextWithImage: View {
    let text: String
    @State private var displayedText: String = ""
    let image: Image
    let imageIndex: Int
    
    var body: some View {
        VStack {
            if imageIndex <= displayedText.count {
                image
                    .resizable()
                    .frame(width: 70,height: 70)
                    .padding()
            }
            Text(displayedText)
                .font(.system(size: 35, weight: .bold))
                .foregroundColor(.white)
                .onAppear {
                    let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                        if displayedText.count < text.count {
                            displayedText += String(text[text.index(text.startIndex, offsetBy: displayedText.count)])
                        } else {
                            timer.invalidate()
                        }
                    }
                    timer.fire()
            }
        }
    }
}


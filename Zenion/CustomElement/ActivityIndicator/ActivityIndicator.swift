//
//  ActivityIndicator.swift
//  Zenion
//
//  Created by macbook on 12.04.23.
//
import SwiftUI
struct ActivityIndicator: View {
     var isAnimating: Bool
      @State private var animating: Bool = false
    var body: some View {
        if isAnimating || animating {
            GeometryReader { (geometry: GeometryProxy) in
                ForEach(0..<5) { index in
                    Group {
                        Circle()
                            .frame(width: geometry.size.width / 5, height: geometry.size.height / 5)
                            .scaleEffect(calcScale(index: index))
                            .offset(y: calcYOffset(geometry))
                    }.frame(width: geometry.size.width, height: geometry.size.height)
                        .rotationEffect(!animating ? .degrees(0) : .degrees(360))
                      .animation(Animation.timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5).repeatForever(autoreverses: false))
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .onAppear {
                animating = isAnimating
            }
        }
    }
    func calcScale(index: Int) -> CGFloat {
        return (!animating ? 1 - CGFloat(Float(index)) / 5 : 0.2 + CGFloat(index) / 5)
    }
    func calcYOffset(_ geometry: GeometryProxy) -> CGFloat {
        return geometry.size.width / 10 - geometry.size.height / 2
    }
}

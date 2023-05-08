//
//  CustomButton.swift
//  Zenion
//
//  Created by macbook on 12.04.23.
//

import SwiftUI

struct CustomButton: View {
    let text: String
    let color: Color
    let Width: CGFloat
    let Height: CGFloat
    let action: () -> Void
    var body: some View {

        Button(action: {
            action()
        },
        label: {
            Text(text)
            .font(.system(size: 17, weight: .bold, design: .rounded))
            .frame(width: Width, height: Height)
        })
          .foregroundColor(.white)
          .background(color)
          .multilineTextAlignment(.center)
          .cornerRadius(20)
          .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.purple, lineWidth: 2)
          )
         
    }
}


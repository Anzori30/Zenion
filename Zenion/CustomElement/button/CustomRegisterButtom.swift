//
//  CustomRegisterButtom.swift
//  Zenion
//
//  Created by macbook on 05.04.23.
//

import SwiftUI

struct CustomRegisterButton<Destination: View>: View {
    let imageName: String
    let text: String
    let color: Color
    let imageWidth: CGFloat
    let imageHeight: CGFloat
    var destination: Destination
    let navigate:Bool
    let action: () -> Void
    @State private var isShowingDetailView = false
    var body: some View {
        NavigationLink(destination: destination, isActive: $isShowingDetailView) {
            HStack{
                Image(imageName)
                    .resizable()
                    .frame(width: imageWidth, height: imageHeight)
               
                Text(text)
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .frame(width: 200)
            }
         
            .frame(width: 300.0, height: 50.0)
            .foregroundColor(.white)
            .background(color)
            .multilineTextAlignment(.center)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.purple, lineWidth: 2)
            )
            .onTapGesture {
                action()
                isShowingDetailView = navigate
            }
        }
        
    }
}

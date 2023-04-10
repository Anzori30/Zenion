//
//  CustomRegisterButtom.swift
//  Zenion
//
//  Created by macbook on 05.04.23.
//

import SwiftUI

struct CustomRegisterButtom: View {
    let imageName:String
    let text:String
    let color: Color
    let imageWidth:CGFloat
    let imageHeight:CGFloat
    let action: () -> Void // Add an action closure property to the view
    var body: some View {
      
            HStack{
            
                Button {
                    action()
                } label: {
                    Image(imageName)
                        .resizable()
                        .frame(width: imageWidth, height: imageHeight)
                    Text(text)
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
                }

      
            }
            .frame(width: 300.0, height: 50.0)
            .foregroundColor(.white)
            .background(color)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.purple, lineWidth: 2)
            )
            
        }
        
    
}

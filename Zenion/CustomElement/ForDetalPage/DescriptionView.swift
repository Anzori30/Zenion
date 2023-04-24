//
//  DescriptionView.swift
//  Zenion
//
//  Created by macbook on 21.04.23.
//

import SwiftUI

struct DescriptionView: View {
    @State private var isExpanded = false
    @State private var lineLimit = 3
    var text:String
    
    var body: some View {
        VStack {
            HStack {
                Text("Description")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .fontWeight(.bold)
                    .padding(.bottom)
                    .foregroundColor(.white)
                Spacer()
            }
            if !isExpanded {
                Text(text)
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.clear, Color("Dark")]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .foregroundColor(Color("textColor"))
                    .lineLimit(lineLimit)
                    .padding(.bottom, 20)
            } else {
                Text(text)
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .foregroundColor(Color("textColor"))
                    .lineLimit(lineLimit)
                    .padding(.bottom, 20)
            }
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) { // Add animation block
                    self.isExpanded.toggle()
                    if self.isExpanded {
                        self.lineLimit = 100
                    } else {
                        self.lineLimit = 3
                    }
                }
            }) {
                if isExpanded {
                    Image(systemName: "chevron.up")
                        .resizable()
                        .frame(width: 25,height: 13)
                        .foregroundColor(Color("textColor"))
                        .font(.headline)
                } else {
                    Image(systemName: "chevron.down")
                        .resizable()
                        .frame(width: 25,height: 13)
                        .foregroundColor(Color("textColor"))
                        .font(.headline)
                }
            }
        }
        .padding([.top,.bottom],20)
    }
}

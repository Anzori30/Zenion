//
//  UserSclorLIstView.swift
//  Zenion
//
//  Created by macbook on 25.04.23.
//

import SwiftUI

struct UserSclorLIstView: View {
    var info = [UserPage]()
   
    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                ForEach(info, id: \.name) { page in
                    Button {
                        page.action()
                    } label: {
                        NavigationLink(destination: page.destination) {
                            HStack {
                                Text(page.name)
                                    .font(.system(size: 17, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                Spacer()
                                Image(systemName: "arrow.right")
                                    .foregroundColor(.gray)
                                    .frame(width: 17, height: 17)
                            }
                            }
                        
                        .disabled(page.navigationDisabled)
                        .padding([.leading, .trailing], 20)
                        .frame(height: 50)
                        .background(Color("Gray"))
                        .cornerRadius(20)
                    
                    }
                }
            }
        }
        .frame(height: CGFloat(info.count) * 60)
    }
}

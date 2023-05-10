//
//  ProfilePageListItem.swift
//  Zenion
//
//  Created by macbook on 06.05.23.
//

import SwiftUI
import Kingfisher
struct ProfilePageListItem: View {
  @State var height:Int
    var mainText:String
    var secundText:String
    var imageLink:String
    var isturnDown:Bool
    var destination:AnyView
    var downText:String
    var navigation:Bool
    let action: () -> Void
    @State private var buttonArrow = "chevron.right"
    @State private var seeMore = false
    var body: some View {
               Button {
                   if isturnDown{
                       withAnimation(.easeInOut(duration: 0.2)){
                                seeMore.toggle()
                       }
                       if seeMore{
                           buttonArrow = "chevron.up"
                       }
                       else{
                           buttonArrow = "chevron.right"
                       }
                   }
                   if !isturnDown{
                       action()
                   }
                        } label: {
                            VStack{
                                HStack{
                                    Text(mainText)
                                        .foregroundColor(.white)
                                        .font(.system(size: 18, weight: .bold, design: .rounded))
                                    
                                    Spacer()
                                    Text(secundText)
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .bold, design: .rounded))
                                    if imageLink != ""{
                                        ShimerAnimation(url: imageLink)
                                            .frame(width: 60,height: 60)
                                            .cornerRadius(100)
                                    }
                                    Image(systemName: buttonArrow)
                                        .frame(width: 20,height: 60)
                                        .foregroundColor(.indigo)
                                }
                            }
                            
                        }
                        .listRowSeparatorTint(Color("light-brown"))
                    .listRowBackground(Color("Gray"))
                   .frame(height: CGFloat(height))
            if seeMore{
                VStack{
                    NavigationLink(destination: destination){
                    Text(downText)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                }
                  .foregroundColor(.white)
                 .disabled(navigation)
            }
            .onTapGesture {
                action()
            }
            .listRowBackground(Color("Gray"))
            .frame(height: 40)
        }
    }
}


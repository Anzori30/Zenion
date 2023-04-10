//
//  CustomListView.swift
//  Zenion
//
//  Created by macbook on 08.04.23.
//

import SwiftUI

struct CustomListView: View {
    let headerText:String
    let images = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "image8", "image9", "image10"]
    let width:Int
    let height:Int
    var body: some View {
        VStack{
            HStack{
                Text(headerText)
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding([.leading],20)
                Spacer()
                NavigationLink( destination: HomeView()){
                    Image(systemName: "square.rightthird.inset.filled")
                        .frame(width: 30,height: 30)
                        .foregroundColor(.gray)
                }
                .padding([.trailing,.bottom],30)
            }
      
            List {
                ForEach(images, id: \.self) { imageName in
                  
                    HStack{
                        Image("test")
                               .resizable()
                               .frame(width: CGFloat(width / 2), height: CGFloat(height))
                               .cornerRadius(30)
                        VStack{
                           
                            Text("Name")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Year")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("ganre")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularis")
                                .font(.system(size: 15))
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                        }
                        .frame(height: CGFloat(height))
                        .padding([.leading,],0)
                    }
                }
                .listRowBackground(Color.clear)
            }
            .padding([.bottom,],-100)
            .cornerRadius(40)
            .listStyle(PlainListStyle())
        }
    }
}

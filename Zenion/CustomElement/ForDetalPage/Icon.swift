//
//  Icon.swift
//  Zenion
//
//  Created by macbook on 25.04.23.
//

import SwiftUI

 struct Icon: View {
    var imageName:String
    var spacer:Bool
    var height:Int
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 20,height:CGFloat(height))
                .foregroundColor(Color("textColor"))
        }
        .padding([.leading,.trailing],50)
        .padding([.top],5)
        .frame(width: 30,height: 30)
        if spacer{
            Text("|")
              .font(.system(size: 25))
              .foregroundColor(.gray)
        }
        
    }
}

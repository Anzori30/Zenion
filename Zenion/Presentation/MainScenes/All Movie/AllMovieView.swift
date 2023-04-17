//
//  AllMovieView.swift
//  Zenion
//
//  Created by macbook on 05.04.23.
//

import SwiftUI

struct AllMovieView: View {
    
    var body: some View {
            ZStack{
                Color("Dark")
                    .ignoresSafeArea()
                CustomListView(headerText: "All", movies: [], width: Int(UIScreen.main.bounds.width), height: Int(UIScreen.main.bounds.height) / 3)
            }
            //zs end
 
    }
}

struct AllMovieView_Previews: PreviewProvider {
    static var previews: some View {
        AllMovieView()
    }
}

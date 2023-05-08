//
//  FavoriteView.swift
//  Zenion
//
//  Created by macbook on 05.04.23.
//

import SwiftUI

struct FavoriteView: View {
    @StateObject var viewModel = FavoriteViewModel()
    var body: some View {
        NavigationView{
            ZStack{
                Color("Dark")
                    .ignoresSafeArea()
              CustomListView(headerText: "Favorite", movies:viewModel.isFavorite, width: Int(UIScreen.main.bounds.width), height: Int(UIScreen.main.bounds.height) / 3)
            }
        }
        .onAppear{
            viewModel.start()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}

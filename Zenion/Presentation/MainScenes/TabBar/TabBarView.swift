//
//  TabBarView.swift
//  Zenion
//
//  Created by macbook on 05.04.23.
//

import SwiftUI



struct TabBarView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            AllMovieView()
                .tabItem {
                    Image(systemName: "rectangle.grid.2x2")
                }
            FavoriteView()
                .tabItem {
                    Image(systemName: "heart")
                }
            userView()
                .tabItem {
                    Image(systemName: "person")
                }
        }
        .navigationBarBackButtonHidden()
        .accentColor(Color.pink)
        .tint(.white)
        .onAppear(){
            UITabBar.appearance().backgroundColor = UIColor(named: "Dark")
            UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        }
    }
}



struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

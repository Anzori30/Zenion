//
//  SearchView.swift
//  Zenion
//
//  Created by macbook on 05.04.23.
//

import SwiftUI
struct SearchView: View {
    @ObservedObject var viewModel = searchViewModel()
    @State private var searchText = ""
    var filterMoview = [movie]()
    init() {
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .black
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    var body: some View {
        NavigationView {
            ZStack{
                Color("Dark")
                    .ignoresSafeArea()
                    .navigationTitle("Search")
                    .searchable(text: $searchText)
                if viewModel.showMovies {
                    if searchText.isEmpty {
                        CustomListView(headerText: "All", movies: viewModel.Searchmovies, width: Int(UIScreen.main.bounds.width), height: Int(UIScreen.main.bounds.height) / 3)
                    } else {
                        CustomListView(headerText: "Searched", movies: viewModel.Searchmovies.filter { movie in
                            movie.name.localizedCaseInsensitiveContains(searchText) ||
                            movie.location.contains(where: { location in location.localizedCaseInsensitiveContains(searchText) }) ||
                            movie.genre.contains(where: { genre in genre.localizedCaseInsensitiveContains(searchText) }) ||
                            movie.actors.contains(where: { actor in actor.localizedCaseInsensitiveContains(searchText) })
                        }, width: Int(UIScreen.main.bounds.width), height: Int(UIScreen.main.bounds.height) / 3)
                    }
                }
                else {
                    Text("No movies found")
                      .foregroundColor(Color("Light"))
                }
                
            }
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .overlay(
            HStack{
                if viewModel.ActivityIndicator {
                   ActivityIndicator(isAnimating: true)
                    .foregroundColor(.red)
                    .frame(width: 80)
               }
        })
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

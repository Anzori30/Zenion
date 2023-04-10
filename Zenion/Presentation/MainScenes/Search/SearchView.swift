//
//  SearchView.swift
//  Zenion
//
//  Created by macbook on 05.04.23.
//

import SwiftUI

struct SearchView: View {
    let colorDark = UIColor(named: "Dark")
    init() {
        UINavigationBar.appearance().backgroundColor = colorDark
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .black
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    @State private var searchText = ""
    var body: some View {
        NavigationStack {
            ZStack{
                Color(uiColor: colorDark!)
                    .ignoresSafeArea()
                    .navigationTitle("Search")
                    .searchable(text: $searchText)
                CustomListView(headerText: "Top", width: Int(UIScreen.main.bounds.width), height: Int(UIScreen.main.bounds.height) / 3)
            }
            //zs end
        }
        //navigation end
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}


//
//  ContentView.swift
//  MoviesDB N-6
//
//  Created by Zuka Papuashvili on 05.06.24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var moviesCollectionViewModel: MoviesCollectionViewModel
    @EnvironmentObject var searchViewModel: SearchViewModel
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    init() {
        setupTabBarAppearance()
    }
    
    var body: some View {
        TabView {
            MoviesCollectionView()
                .tabItem {
                    Image("NavHome")
                        .renderingMode(.template)
                        .foregroundColor(.primary)
                    Text("Home")
                }
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            FavoritesView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
        }
        .accentColor(.blue)
    }
    
    private func setupTabBarAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .movieBackGround
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}

#Preview {
    let moviesCollectionViewModel = MoviesCollectionViewModel()
    let searchViewModel = SearchViewModel()
    let favoritesViewModel = FavoritesViewModel()
    
    return ContentView()
        .environmentObject(moviesCollectionViewModel)
        .environmentObject(searchViewModel)
        .environmentObject(favoritesViewModel)
        .modelContainer(DataController.previewContainer)
}

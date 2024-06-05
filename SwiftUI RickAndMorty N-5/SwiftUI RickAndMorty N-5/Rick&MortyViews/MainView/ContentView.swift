//
//  ContentView.swift
//  SwiftUI RickAndMorty N-5
//
//  Created by Zuka Papuashvili on 31.05.24.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(Color.navColors)
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
    
    var body: some View {
        TabView {
            CharactersView()
                .tabItem {
                    Label("Characters", systemImage: "person.3.fill")
                }
            
            EpisodesView()
                .tabItem {
                    Label("Episodes", systemImage: "tv.fill")
                }
                .environmentObject(EpisodesViewModel())
            
            LocationsView()
                .tabItem {
                    Label("Locations", systemImage: "globe")
                }
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
        .accentColor(.orange)
    }
}

#Preview {
    ContentView()
}

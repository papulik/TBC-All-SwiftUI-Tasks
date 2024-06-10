//
//  MoviesDB_N_6App.swift
//  MoviesDB N-6
//
//  Created by Zuka Papuashvili on 04.06.24.
//

import SwiftUI
import SwiftData

@main
struct MoviesDB_N_6App: App {
    @StateObject private var moviesCollectionViewModel = MoviesCollectionViewModel()
    @StateObject private var searchViewModel = SearchViewModel()
    @StateObject private var favoritesViewModel = FavoritesViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(moviesCollectionViewModel)
                .environmentObject(searchViewModel)
                .environmentObject(favoritesViewModel)
        }
        .modelContainer(for: FavoriteMovie.self)
    }
}

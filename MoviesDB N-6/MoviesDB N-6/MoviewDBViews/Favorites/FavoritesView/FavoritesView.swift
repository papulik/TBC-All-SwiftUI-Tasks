//
//  FavoritesView.swift
//  MoviesDB N-6
//
//  Created by Zuka Papuashvili on 08.06.24.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @EnvironmentObject var viewModel: FavoritesViewModel
    @Environment(\.modelContext) private var context: ModelContext

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.favoriteMovies.isEmpty {
                    placeholderView
                } else {
                    favoritesList
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)  // Ensure the VStack takes up all available space
            .background(Color.movieBackGround.ignoresSafeArea())  // Apply background color to the entire view
            .navigationTitle("Favorites")
        }
        .onAppear {
            viewModel.fetchFavorites(context: context)
        }
    }

    private var favoritesList: some View {
        List {
            ForEach(viewModel.favoriteMovies) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie.toMoviesInfo())) {
                    ReusableListCell(movie: movie.toMoviesInfo())
                        
                }
            }
            .listRowBackground(Color.movieBackGround)
            .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
        .background(Color.clear)  // Use clear background to prevent it from overriding the outer background
    }

    private var placeholderView: some View {
        VStack {
            Spacer()
            Text("No favorites yet!")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.bottom, 8)
            Text("All movies marked as favourite will be added here")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 24)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.movieBackGround)
    }
}

#Preview {
    let viewModel = FavoritesViewModel()

    return FavoritesView()
        .environmentObject(viewModel)
        .modelContainer(for: FavoriteMovie.self)
}

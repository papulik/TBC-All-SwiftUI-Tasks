//
//  MovieDetailView.swift
//  MoviesDB N-6
//
//  Created by Zuka Papuashvili on 07.06.24.
//

import SwiftUI
import SwiftData

struct MovieDetailView: View {
    let movie: MoviesInfo
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    @Environment(\.modelContext) private var context: ModelContext

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                backdropImage
                posterAndTitle
                centeredMovieInformation
                movieOverview
            }
            .navigationTitle(movie.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private var backdropImage: some View {
        ZStack(alignment: .bottomTrailing) {
            AsyncImageView(url: movie.backdropURL)
                .frame(height: 200)
                .cornerRadius(20)

            RatingView(rating: movie.rating)
                .padding(.trailing, 16)
                .padding(.bottom, 16)
        }
    }
    
    private var posterAndTitle: some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImageView(url: movie.posterURL)
                .frame(width: 100, height: 150)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.leading, 16)
                .padding(.top, -85)

            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 8)
            }
        }
        .padding(.bottom, 8)
    }
    
    private var centeredMovieInformation: some View {
        HStack {
            Spacer()
            MovieInformationView(
                releaseDate: movie.releaseDate,
                duration: movie.duration,
                genre: movie.genre
            )
            Spacer()
        }
        .padding(.top, 10)
        .padding(.bottom, 16)
    }
    
    private var movieOverview: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("About Movie")
                    .font(.headline)
                    .padding(.bottom, 4)
                
                Spacer()
                
                Button(action: toggleFavorite) {
                    Image(systemName: favoritesViewModel.isFavorite(movie) ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 21, height: 20)
                        .foregroundColor(.red)
                }
            }
            .padding(.horizontal, 5)
            
            Rectangle()
                .frame(height: 4)
                .foregroundColor(.gray)
                .padding(.bottom, 4)

            Text(movie.overview ?? "No description available.")
                .font(.body)
                .foregroundColor(.secondary)
                .padding(.horizontal, 5)
        }
        .padding(.horizontal, 16)
    }

    private func toggleFavorite() {
        if favoritesViewModel.isFavorite(movie) {
            favoritesViewModel.removeFavorite(movie: movie, context: context)
        } else {
            favoritesViewModel.addFavorite(movie: movie, context: context)
        }
    }
}

#Preview {
    let movie = MoviesInfo(
        id: 1,
        title: "Sample Movie",
        posterPath: "/path.jpg",
        backdropPath: "/backdrop.jpg",
        rating: 7.5,
        genreIDs: [28, 12],
        releaseDate: "2021-01-01",
        duration: 120,
        overview: "This is a sample movie description."
    )

    return MovieDetailView(movie: movie)
        .environmentObject(FavoritesViewModel())
        .modelContainer(for: FavoriteMovie.self)
}

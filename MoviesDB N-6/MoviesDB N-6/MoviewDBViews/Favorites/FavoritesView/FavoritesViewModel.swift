//
//  FavoritesViewModel.swift
//  MoviesDB N-6
//
//  Created by Zuka Papuashvili on 08.06.24.
//

import Observation
import SwiftData
import SwiftUI

final class FavoritesViewModel: ObservableObject {
    @Published var favoriteMovies: [FavoriteMovie] = []
    
    func fetchFavorites(context: ModelContext) {
        let fetchDescriptor = FetchDescriptor<FavoriteMovie>(sortBy: [SortDescriptor(\FavoriteMovie.title)])
        do {
            favoriteMovies = try context.fetch(fetchDescriptor)
        } catch {
            print("Failed to fetch favorites: \(error)")
        }
    }

    func addFavorite(movie: MoviesInfo, context: ModelContext) {
        let favoriteMovie = FavoriteMovie(
            id: Int32(movie.id),
            title: movie.title,
            posterPath: movie.posterPath,
            backdropPath: movie.backdropPath,
            rating: movie.rating,
            genreIDs: movie.genreIDs,
            releaseDate: movie.releaseDate,
            duration: Int32(movie.duration ?? 0),
            overview: movie.overview ?? ""
        )
        context.insert(favoriteMovie)
        favoriteMovies.append(favoriteMovie)
    }
    
    func removeFavorite(movie: MoviesInfo, context: ModelContext) {
        if let favoriteMovie = favoriteMovies.first(where: { $0.id == Int32(movie.id) }) {
            context.delete(favoriteMovie)
            favoriteMovies.removeAll { $0.id == favoriteMovie.id }
        }
    }
    
    func isFavorite(_ movie: MoviesInfo) -> Bool {
        return favoriteMovies.contains { $0.id == Int32(movie.id) }
    }
}

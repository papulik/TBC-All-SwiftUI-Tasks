//
//  FavoriteMovie.swift
//  MoviesDB N-6
//
//  Created by Zuka Papuashvili on 08.06.24.
//

import Foundation
import SwiftData

@Model
final class FavoriteMovie: Identifiable {
    var id: Int32
    var title: String
    var posterPath: String?
    var backdropPath: String?
    var rating: Double
    var genreIDs: [Int]
    var releaseDate: String
    var duration: Int32
    var overview: String?
    
    init(id: Int32, title: String, posterPath: String? = nil, backdropPath: String? = nil, rating: Double, genreIDs: [Int], releaseDate: String, duration: Int32, overview: String? = nil) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.rating = rating
        self.genreIDs = genreIDs
        self.releaseDate = releaseDate
        self.duration = duration
        self.overview = overview
    }
    
    func toMoviesInfo() -> MoviesInfo {
        return MoviesInfo(
            id: Int(id),
            title: title,
            posterPath: posterPath,
            backdropPath: backdropPath,
            rating: rating,
            genreIDs: genreIDs,
            releaseDate: releaseDate,
            duration: Int(duration),
            overview: overview
        )
    }
}

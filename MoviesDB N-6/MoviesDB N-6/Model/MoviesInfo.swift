//
//  MoviesInfo.swift
//  MoviesDB N-6
//
//  Created by Zuka Papuashvili on 05.06.24.
//

import Foundation

struct MoviesInfo: Decodable, Identifiable {
    let id: Int
    let title: String
    let posterPath: String?
    let backdropPath: String?
    let rating: Double
    let genreIDs: [Int]
    let releaseDate: String
    var duration: Int?
    var overview: String?

    var genre: String {
        let genres = [
            28: "Action",
            12: "Adventure",
            16: "Animation",
            35: "Comedy",
            80: "Crime",
            99: "Documentary",
            18: "Drama",
            10751: "Family",
            14: "Fantasy",
            36: "History",
            27: "Horror",
            10402: "Music",
            9648: "Mystery",
            10749: "Romance",
            878: "Science Fiction",
            10770: "TV Movie",
            53: "Thriller",
            10752: "War",
            37: "Western"
        ]
        return genreIDs.compactMap { genres[$0] }.joined(separator: ", ")
    }

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case rating = "vote_average"
        case genreIDs = "genre_ids"
        case releaseDate = "release_date"
        case duration = "runtime"
        case overview
    }

    var posterURL: URL? {
        if let posterPath = posterPath {
            return URL(string: "\(Constants.imageBaseURL)\(posterPath)")
        }
        return nil
    }

    var backdropURL: URL? {
        if let backdropPath = backdropPath {
            return URL(string: "\(Constants.imageBaseURL)\(backdropPath)")
        }
        return nil
    }
}

struct MovieResponse: Decodable {
    let results: [MoviesInfo]
}

struct MovieDetailsResponse: Decodable {
    let runtime: Int?
}

struct GenreResponse: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable {
    let id: Int
    let name: String
}

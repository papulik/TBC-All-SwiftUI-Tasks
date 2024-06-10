//
//  Constants.swift
//  MoviesDB N-6
//
//  Created by Zuka Papuashvili on 07.06.24.
//

import Foundation

struct Constants {
    static let baseURL = "https://api.themoviedb.org/3/"
    static let apiKey = "ecb5971b714c561e5751f4d2de679575"
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    
    struct Endpoints {
        static let searchMovie = baseURL + "search/movie?api_key=\(apiKey)&query="
        static let discoverMovieByGenre = baseURL + "discover/movie?api_key=\(apiKey)&with_genres="
        static let discoverMovieByYear = baseURL + "discover/movie?api_key=\(apiKey)&primary_release_year="
        static let movieDetails = baseURL + "movie/"
        static let genresList = baseURL + "genre/movie/list?api_key=\(apiKey)"
        static let popularMovies = baseURL + "movie/popular?api_key=\(apiKey)"
    }
}

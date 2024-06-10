//
//  MoviesCollectionViewModel.swift
//  MoviesDB N-6
//
//  Created by Zuka Papuashvili on 05.06.24.
//

import Foundation
import SimpleNetworking

final class MoviesCollectionViewModel: ObservableObject {
    @Published var movies: [MoviesInfo] = []
    private let networkingService: NetworkingService

    init(networkingService: NetworkingService = NetworkingService.shared) {
        self.networkingService = networkingService
        fetchMovies()
    }

    func fetchMovies() {
        let urlString = "\(Constants.baseURL)movie/popular?api_key=\(Constants.apiKey)"
        guard let url = URL(string: urlString) else { return }

        networkingService.fetchData(from: url) { (result: Result<MovieResponse, Error>) in
            switch result {
            case .success(let movieResponse):
                var movies = movieResponse.results
                let group = DispatchGroup()

                for i in 0..<movies.count {
                    group.enter()
                    self.fetchMovieDetails(for: movies[i].id) { duration in
                        movies[i].duration = duration
                        group.leave()
                    }
                }

                group.notify(queue: .main) {
                    self.movies = movies
                }

            case .failure(let error):
                print("Failed to search movies: \(error)")
            }
        }
    }
    
    private func fetchMovieDetails(for movieId: Int, completion: @escaping (Int?) -> Void) {
        let urlString = Constants.Endpoints.movieDetails + "\(movieId)?api_key=\(Constants.apiKey)"
        guard let url = URL(string: urlString) else { return }
        
        networkingService.fetchData(from: url) { (result: Result<MovieDetailsResponse, Error>) in
            switch result {
            case .success(let movieDetails):
                completion(movieDetails.runtime)
            case .failure(let error):
                print("Failed to fetch movie details: \(error)")
                completion(nil)
            }
        }
    }
}

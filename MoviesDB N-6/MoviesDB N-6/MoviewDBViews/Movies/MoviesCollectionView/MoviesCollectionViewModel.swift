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
                self.movies = movieResponse.results
            case .failure(let error):
                print("Failed to fetch movies: \(error)")
            }
        }
    }
}

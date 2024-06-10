//
//  SearchViewModel.swift
//  MoviesDB N-6
//
//  Created by Zuka Papuashvili on 05.06.24.
//

import Foundation
import SimpleNetworking

final class SearchViewModel: ObservableObject {
    @Published var searchResults: [MoviesInfo] = []
    @Published var searchOption: SearchOption = .name {
        didSet {
            searchResults.removeAll()
        }
    }
    @Published var genres: [String: Int] = [:]
    private let networkingService: NetworkingService

    init(networkingService: NetworkingService = .shared) {
        self.networkingService = networkingService
        fetchGenres()
    }

    private func fetchGenres() {
        guard let url = URL(string: Constants.Endpoints.genresList) else { return }

        networkingService.fetchData(from: url) { (result: Result<GenreResponse, Error>) in
            switch result {
            case .success(let genreResponse):
                var genreDict: [String: Int] = [:]
                for genre in genreResponse.genres {
                    genreDict[genre.name.lowercased()] = genre.id
                }
                self.genres = genreDict
            case .failure(let error):
                print("Failed to fetch genres: \(error)")
            }
        }
    }

    func searchMovies(query: String, completion: @escaping () -> Void) {
        var urlString: String

        switch searchOption {
        case .name:
            if query.isEmpty {
                searchResults.removeAll()
                completion()
                return
            }
            urlString = Constants.Endpoints.searchMovie + query
        case .genre:
            if let genreId = genres[query.lowercased()] {
                urlString = Constants.Endpoints.discoverMovieByGenre + "\(genreId)"
            } else {
                searchResults.removeAll()
                completion()
                return
            }
        case .releaseYear:
            guard validateYear(query) else {
                searchResults.removeAll()
                completion()
                return
            }
            urlString = Constants.Endpoints.discoverMovieByYear + query
        }

        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else { return }

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
                    self.searchResults = movies
                    completion()
                }

            case .failure(let error):
                print("Failed to search movies: \(error)")
                self.searchResults.removeAll()
                completion()
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

    private func validateYear(_ year: String) -> Bool {
        let yearRegex = "^[0-9]{4}$"
        let yearPredicate = NSPredicate(format: "SELF MATCHES %@", yearRegex)
        return yearPredicate.evaluate(with: year)
    }
}

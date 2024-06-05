//
//  SearchViewModel.swift
//  SwiftUI RickAndMorty N-5
//
//  Created by Zuka Papuashvili on 31.05.24.
//

import Foundation
import SimpleNetworking

final class SearchViewModel: ObservableObject {
    @Published var searchResults = [Character]()
    @Published var episodeResults = [Episode]()
    @Published var locationResults = [Location]()
    @Published var isLoading = false
    @Published var errorMessage: String?

    func searchCharacters(query: String) {
        isLoading = true
        errorMessage = nil

        let urlString = "https://rickandmortyapi.com/api/character/?name=\(query)"
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else { return }

        NetworkingService.shared.fetchData(from: url) { (result: Result<CharactersResponse, Error>) in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let response):
                    self.searchResults = response.results
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func searchEpisodes(query: String) {
        isLoading = true
        errorMessage = nil

        let urlString = "https://rickandmortyapi.com/api/episode/?name=\(query)"
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else { return }

        NetworkingService.shared.fetchData(from: url) { (result: Result<EpisodesResponse, Error>) in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let response):
                    self.episodeResults = response.results
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func searchLocations(query: String) {
        isLoading = true
        errorMessage = nil

        let urlString = "https://rickandmortyapi.com/api/location/?name=\(query)"
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else { return }

        NetworkingService.shared.fetchData(from: url) { (result: Result<LocationsResponse, Error>) in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let response):
                    self.locationResults = response.results
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

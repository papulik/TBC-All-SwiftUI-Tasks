//
//  EpisodesViewModel.swift
//  SwiftUI RickAndMorty N-5
//
//  Created by Zuka Papuashvili on 31.05.24.
//

import Foundation
import SimpleNetworking
import SwiftUI

final class EpisodesViewModel: ObservableObject {
    @Published var episodes = [Episode]()
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var navigationPath = [Episode]()

    @AppStorage("favoriteEpisodes") private var favoriteEpisodes: Set<Int> = []

    let imageNames = [
        "Abadango", "Anatomy Park", "Bepis 9", "Bird World", "Citadel of Ricks", "Cronenberg Earth",
        "Earth (5-126)", "Earth (C-137)", "Earth (Replacement Dimension)", "Giant's Town", "Gromflom Prime",
        "Immortality Field Resort", "Interdimensional Cable", "Mr. Goldenfold's dream", "Nuptia 4",
        "Post-Apocalyptic Earth", "Purge Planet", "St. Gloopy Noops Hospital", "Venzenulon 7",
        "Worldender's lair"
    ]

    func fetchEpisodes() {
        DispatchQueue.main.async {
            self.isLoading = true
            self.errorMessage = nil
        }

        let url = URL(string: "https://rickandmortyapi.com/api/episode")!
        NetworkingService.shared.fetchData(from: url) { (result: Result<EpisodesResponse, Error>) in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let response):
                    self.episodes = response.results
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func isFavorite(_ episode: Episode) -> Bool {
        favoriteEpisodes.contains(episode.id)
    }
    
    func toggleFavorite(_ episode: Episode) {
        DispatchQueue.main.async {
            if self.favoriteEpisodes.contains(episode.id) {
                self.favoriteEpisodes.remove(episode.id)
            } else {
                self.favoriteEpisodes.insert(episode.id)
            }
        }
    }
    
    func getImageName(for index: Int) -> String {
        return imageNames[index % imageNames.count]
    }
}


struct EpisodesResponse: Decodable {
    let results: [Episode]
}

extension Set: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode(Set<Element>.self, from: data) else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8) else {
            return ""
        }
        return result
    }
}

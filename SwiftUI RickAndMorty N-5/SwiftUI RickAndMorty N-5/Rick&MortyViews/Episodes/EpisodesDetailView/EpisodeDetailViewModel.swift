//
//  EpisodeDetailViewModel.swift
//  SwiftUI RickAndMorty N-5
//
//  Created by Zuka Papuashvili on 31.05.24.
//

import Foundation
import SimpleNetworking

final class EpisodeDetailViewModel: ObservableObject {
    @Published var characters = [Character]()
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let episode: Episode

    init(episode: Episode) {
        self.episode = episode
    }

    func fetchCharacters(for episode: Episode) {
        DispatchQueue.main.async {
            self.isLoading = true
            self.errorMessage = nil
            self.characters = []
        }

        let dispatchGroup = DispatchGroup()

        for urlString in episode.characters {
            dispatchGroup.enter()
            guard let url = URL(string: urlString) else {
                DispatchQueue.main.async {
                    self.errorMessage = "Invalid URL: \(urlString)"
                }
                dispatchGroup.leave()
                continue
            }

            NetworkingService.shared.fetchData(from: url) { (result: Result<Character, Error>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let character):
                        self.characters.append(character)
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                    }
                    dispatchGroup.leave()
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            DispatchQueue.main.async {
                self.isLoading = false
                if self.errorMessage == nil && self.characters.isEmpty {
                    self.errorMessage = "No characters found"
                }
            }
        }
    }
}

//
//  CharacterDetailViewModel.swift
//  SwiftUI RickAndMorty N-5
//
//  Created by Zuka Papuashvili on 31.05.24.
//

import Foundation
import SimpleNetworking

final class CharacterDetailViewModel: ObservableObject {
    @Published var episodeNames = [String]()
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var episodeCharacters = [String: [Character]]()
    @Published var expandedEpisodes = Set<String>()
    
    private let character: Character
    
    init(character: Character) {
        self.character = character
    }

    func fetchEpisodeNames() {
        DispatchQueue.main.async {
            self.isLoading = true
            self.errorMessage = nil
            self.episodeNames = []
        }

        let dispatchGroup = DispatchGroup()
        
        for urlString in character.episode {
            dispatchGroup.enter()
            guard let url = URL(string: urlString) else {
                DispatchQueue.main.async {
                    self.errorMessage = "Invalid URL: \(urlString)"
                }
                dispatchGroup.leave()
                continue
            }
            
            NetworkingService.shared.fetchData(from: url) { (result: Result<Episode, Error>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let episode):
                        self.episodeNames.append(episode.name)
                        self.fetchCharacters(for: episode)
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
                if self.errorMessage == nil && self.episodeNames.isEmpty {
                    self.errorMessage = "No episodes found"
                }
            }
        }
    }
    
    func fetchCharacters(for episode: Episode) {
        let characterUrls = episode.characters
        var characters = [Character]()
        let dispatchGroup = DispatchGroup()
        
        for urlString in characterUrls {
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
                        characters.append(character)
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                    }
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            DispatchQueue.main.async {
                self.episodeCharacters[episode.name] = characters
            }
        }
    }

    func toggleEpisodeExpansion(_ episodeName: String) {
        if expandedEpisodes.contains(episodeName) {
            expandedEpisodes.remove(episodeName)
        } else {
            expandedEpisodes.insert(episodeName)
        }
    }
}

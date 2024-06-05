//
//  CharactersViewModel.swift
//  SwiftUI RickAndMorty N-5
//
//  Created by Zuka Papuashvili on 31.05.24.
//

import Foundation
import SimpleNetworking

final class CharactersViewModel: ObservableObject {
    @Published var characters = [Character]()
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var navigationPath = [Character]()

    func fetchCharacters() {
        isLoading = true
        errorMessage = nil

        let url = URL(string: "https://rickandmortyapi.com/api/character")!
        NetworkingService.shared.fetchData(from: url) { (result: Result<CharactersResponse, Error>) in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let response):
                    self.characters = response.results
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

struct CharactersResponse: Decodable {
    let results: [Character]
}

//
//  LocationsViewModel.swift
//  SwiftUI RickAndMorty N-5
//
//  Created by Zuka Papuashvili on 31.05.24.
//

import Foundation
import SimpleNetworking

final class LocationsViewModel: ObservableObject {
    @Published var locations = [Location]()
    @Published var isLoading = false
    @Published var errorMessage: String?

    let imageNames = [
        "Abadango", "Anatomy Park", "Bepis 9", "Bird World", "Citadel of Ricks", "Cronenberg Earth",
        "Earth (5-126)", "Earth (C-137)", "Earth (Replacement Dimension)", "Giant's Town", "Gromflom Prime",
        "Immortality Field Resort", "Interdimensional Cable", "Mr. Goldenfold's dream", "Nuptia 4",
        "Post-Apocalyptic Earth", "Purge Planet", "St. Gloopy Noops Hospital", "Venzenulon 7",
        "Worldender's lair"
    ]

    func fetchLocations() {
        isLoading = true
        errorMessage = nil

        let url = URL(string: "https://rickandmortyapi.com/api/location")!
        NetworkingService.shared.fetchData(from: url) { (result: Result<LocationsResponse, Error>) in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let response):
                    self.locations = response.results
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func getImageName(for index: Int) -> String {
        return imageNames[index % imageNames.count]
    }
}

struct LocationsResponse: Decodable {
    let results: [Location]
}

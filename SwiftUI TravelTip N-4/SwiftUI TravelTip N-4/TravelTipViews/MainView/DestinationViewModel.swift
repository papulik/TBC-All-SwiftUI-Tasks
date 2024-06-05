//
//  DestinationViewModel.swift
//  SwiftUI TravelTip N-4
//
//  Created by Zuka Papuashvili on 29.05.24.
//

import Foundation
import SimpleNetworking

class DestinationViewModel: ObservableObject {
    @Published var destinations: [TripInfo] = []
    @Published var showingAlert = false
    @Published var alertMessage = ""
    
    func loadDestinations() {
        guard let url = URL(string: "https://mocki.io/v1/abb08029-9c46-45b2-8bbf-794b02dd4405") else {
            return
        }
        
        NetworkingService.shared.fetchData(from: url) { [weak self] (result: Result<[TripInfo], Error>) in
            switch result {
            case .success(let destinations):
                self?.destinations = destinations
            case .failure(let error):
                print("Error fetching destinations: \(error)")
            }
        }
    }
    
    func showTravelTips() {
        let tips = ["Pack light 🕯️", "Always carry a map 🗺️", "Learn basic phrases of the local language 🗣️", "Carry a power bank 🔋"]
        alertMessage = tips.randomElement() ?? "Wazzaaap!"
        showingAlert = true
    }
}

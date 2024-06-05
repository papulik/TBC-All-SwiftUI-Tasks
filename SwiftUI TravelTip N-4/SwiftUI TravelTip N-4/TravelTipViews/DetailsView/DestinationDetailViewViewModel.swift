//
//  DestinationDetailViewViewModel.swift
//  SwiftUI TravelTip N-4
//
//  Created by Zuka Papuashvili on 29.05.24.
//

import Foundation

class DestinationDetailViewViewModel: ObservableObject {
    @Published var destination: TripInfo
    @Published var imageOpacity: Double = 0
    @Published var imageScale: CGFloat = 0.8
    
    init(destination: TripInfo) {
        self.destination = destination
    }
}

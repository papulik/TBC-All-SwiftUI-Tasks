//
//  HotelsViewModel.swift
//  SwiftUI TravelTip N-4
//
//  Created by Zuka Papuashvili on 29.05.24.
//

import Foundation

class HotelsViewModel: ObservableObject {
    @Published var destination: TripInfo
    @Published var imageOpacity: Double = 0
    @Published var headerOpacity: Double = 0
    @Published var hotelsOpacity: [Double]
    
    init(destination: TripInfo) {
        self.destination = destination
        self.hotelsOpacity = Array(repeating: 0, count: destination.hotels.count)
    }
}

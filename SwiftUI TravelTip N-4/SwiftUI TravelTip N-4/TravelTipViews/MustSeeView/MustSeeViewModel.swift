//
//  MustSeeViewModel.swift
//  SwiftUI TravelTip N-4
//
//  Created by Zuka Papuashvili on 29.05.24.
//

import Foundation

class MustSeeViewModel: ObservableObject {
    @Published var destination: TripInfo
    @Published var imageOffset: CGFloat = 300
    @Published var headerOffset: CGFloat = 300
    @Published var attractionsOffset: [CGFloat]
    
    init(destination: TripInfo) {
        self.destination = destination
        self.attractionsOffset = Array(repeating: 300, count: destination.sightseeingAttractions.count)
    }
}

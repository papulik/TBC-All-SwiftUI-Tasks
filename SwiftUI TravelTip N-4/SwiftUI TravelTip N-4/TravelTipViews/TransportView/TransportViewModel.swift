//
//  TransportViewModel.swift
//  SwiftUI TravelTip N-4
//
//  Created by Zuka Papuashvili on 29.05.24.
//

import Foundation

class TransportViewModel: ObservableObject {
    @Published var destination: TripInfo
    @Published var imageOpacity: Double = 0
    @Published var imageScale: CGFloat = 0.8
    @Published var headerOpacity: Double = 0
    @Published var headerScale: CGFloat = 0.8
    
    init(destination: TripInfo) {
        self.destination = destination
    }
}

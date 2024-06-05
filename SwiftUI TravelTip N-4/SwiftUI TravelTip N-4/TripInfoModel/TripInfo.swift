//
//  TripInfo.swift
//  SwiftUI TravelTip N-4
//
//  Created by Zuka Papuashvili on 29.05.24.
//

import Foundation

struct TripInfo: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let description: String
    let country: String
    let region: String
    let population: Int
    let nationality: String
    let imageName: String
    let transportOptions: [String]
    let sightseeingAttractions: [String]
    let hotels: [String]
}

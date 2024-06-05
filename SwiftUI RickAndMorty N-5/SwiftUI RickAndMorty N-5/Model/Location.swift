//
//  Location.swift
//  SwiftUI RickAndMorty N-5
//
//  Created by Zuka Papuashvili on 31.05.24.
//

import Foundation

struct Location: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}


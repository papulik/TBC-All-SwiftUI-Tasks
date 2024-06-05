//
//  Episode.swift
//  SwiftUI RickAndMorty N-5
//
//  Created by Zuka Papuashvili on 31.05.24.
//

import Foundation

struct Episode: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}

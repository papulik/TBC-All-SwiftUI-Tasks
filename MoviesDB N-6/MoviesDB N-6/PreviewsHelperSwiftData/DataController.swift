//
//  DataController.swift
//  MoviesDB N-6
//
//  Created by Zuka Papuashvili on 09.06.24.
//

import Foundation
import SwiftData
import SwiftUI

@MainActor
class DataController {
    static let previewContainer: ModelContainer = {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: FavoriteMovie.self, configurations: config)

            for i in 1...9 {
                let movie = FavoriteMovie(
                    id: Int32(i),
                    title: "Example Movie \(i)",
                    rating: Double.random(in: 1...10),
                    genreIDs: [28, 12],
                    releaseDate: "202\(i)-01-01",
                    duration: Int32.random(in: 90...180),
                    overview: "Overview of Example Movie \(i)"
                )
                container.mainContext.insert(movie)
            }

            return container
        } catch {
            fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
        }
    }()
}

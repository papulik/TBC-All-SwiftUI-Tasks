//
//  MoviesCollectionView.swift
//  MoviesDB N-6
//
//  Created by Zuka Papuashvili on 04.06.24.
//

import SwiftUI

struct MoviesCollectionView: View {
    @EnvironmentObject var viewModel: MoviesCollectionViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                movieGrid
                    .padding()
            }
            .navigationTitle("Movies")
            .background(Color.movieBackGround.ignoresSafeArea())
        }
    }

    private var movieGrid: some View {
        let columns = [
            GridItem(.adaptive(minimum: 100), spacing: 16)
        ]
        
        return LazyVGrid(columns: columns, spacing: 16) {
            ForEach(viewModel.movies) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie)) {
                    MovieCellView(movie: movie)
                }
            }
        }
    }
}

#Preview {
    let viewModel = MoviesCollectionViewModel()
    viewModel.movies = [
        MoviesInfo(id: 1, title: "Movie 1", posterPath: "/path1.jpg", backdropPath: "/backdrop1.jpg", rating: 8.5, genreIDs: [28, 12], releaseDate: "2023-01-01", duration: 120, overview: "Overview of Movie 1"),
        MoviesInfo(id: 2, title: "Movie 2", posterPath: "/path2.jpg", backdropPath: "/backdrop2.jpg", rating: 7.5, genreIDs: [35, 18], releaseDate: "2022-01-01", duration: 110, overview: "Overview of Movie 2"),
        MoviesInfo(id: 3, title: "Movie 3", posterPath: nil, backdropPath: "/backdrop3.jpg", rating: 6.5, genreIDs: [16, 10751], releaseDate: "2021-01-01", duration: 90, overview: "Overview of Movie 3")
    ]
    return MoviesCollectionView()
        .environmentObject(viewModel)
}

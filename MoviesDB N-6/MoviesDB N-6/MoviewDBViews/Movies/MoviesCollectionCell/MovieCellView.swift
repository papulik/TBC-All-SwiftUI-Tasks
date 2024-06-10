//
//  MovieCellView.swift
//  MoviesDB N-6
//
//  Created by Zuka Papuashvili on 05.06.24.
//

import SwiftUI

struct MovieCellView: View {
    let movie: MoviesInfo

    var body: some View {
        VStack {
            posterImage
            Text(movie.title)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(2)
                .frame(width: 100, height: 40)
        }
        .frame(width: 100, height: 200)
        .background(Color.clear)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }

    private var posterImage: some View {
        Group {
            if let posterURL = movie.posterURL {
                AsyncImage(url: posterURL) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray
                }
                .frame(width: 100, height: 150)
                .cornerRadius(8)
                .clipped()
            } else {
                Color.gray
                    .frame(width: 100, height: 150)
                    .cornerRadius(8)
            }
        }
    }
}

#Preview {
    MovieCellView(movie: MoviesInfo(
        id: 1,
        title: "Sample Movie",
        posterPath: "/path.jpg",
        backdropPath: "/backdrop.jpg",
        rating: 7.5,
        genreIDs: [28, 12],
        releaseDate: "2021-01-01",
        duration: 120,
        overview: "This is a sample movie description."
    ))
}

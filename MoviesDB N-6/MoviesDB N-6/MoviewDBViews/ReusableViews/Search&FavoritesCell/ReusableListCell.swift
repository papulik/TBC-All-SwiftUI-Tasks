//
//  ReusableListCell.swift
//  MoviesDB N-6
//
//  Created by Zuka Papuashvili on 07.06.24.
//

import SwiftUI

struct ReusableListCell: View {
    let movie: MoviesInfo
    
    var body: some View {
        HStack {
            posterImage
            VStack(alignment: .leading, spacing: 5) {
                Text(movie.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                HStack {
                    Image(systemName: "star")
                        .foregroundColor(.orange)
                    Text("\(movie.rating, specifier: "%.1f")")
                        .font(.subheadline)
                        .foregroundColor(.orange)
                }
                
                HStack {
                    Image("Ticket")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.primary)
                        .frame(width: 18, height: 18)
                    Text(movie.genre)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Image("CalendarBlank")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.primary)
                        .frame(width: 18, height: 18)
                    Text(movie.releaseDate)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                if let duration = movie.duration {
                    HStack {
                        Image(systemName: "clock")
                        Text("\(duration) minutes")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            Spacer()
        }
        .padding()
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
                .frame(width: 80, height: 120)
                .cornerRadius(8)
                .clipped()
            } else {
                Color.gray
                    .frame(width: 80, height: 120)
                    .cornerRadius(8)
            }
        }
    }
}

//
//  MovieInformationView.swift
//  MoviesDB N-6
//
//  Created by Zuka Papuashvili on 07.06.24.
//

import SwiftUI

struct MovieInformationView: View {
    let releaseDate: String
    let duration: Int?
    let genre: String

    var body: some View {
        HStack {
            HStack(spacing: 2) {
                Image("CalendarBlank")
                    .resizable()
                    .frame(width: 18, height: 18)
                Text(releaseDate.prefix(4))
            }
            .padding(.trailing, 8)

            HStack(spacing: 2) {
                Image(systemName: "clock")
                Text("\(duration ?? 0) Minutes")
            }
            .padding(.trailing, 8)

            HStack(spacing: 2) {
                Image("Ticket")
                    .resizable()
                    .frame(width: 18, height: 18)
                Text(genre)
            }
        }
        .font(.subheadline)
        .foregroundColor(.secondary)
    }
}

#Preview {
    MovieInformationView(releaseDate: "2021-01-01", duration: 120, genre: "Action, Adventure")
}

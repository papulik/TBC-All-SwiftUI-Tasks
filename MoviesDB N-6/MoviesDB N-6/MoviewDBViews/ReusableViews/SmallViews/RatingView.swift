//
//  RatingView.swift
//  MoviesDB N-6
//
//  Created by Zuka Papuashvili on 07.06.24.
//

import SwiftUI

struct RatingView: View {
    let rating: Double

    var body: some View {
        HStack {
            Image(systemName: "star")
                .foregroundColor(.orange)
            Text("\(rating, specifier: "%.1f")")
                .font(.headline)
                .foregroundColor(.orange)
        }
        .padding(8)
        .background(Color.black.opacity(0.7))
        .cornerRadius(10)
    }
}

#Preview {
    RatingView(rating: 8.5)
}

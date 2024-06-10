//
//  AsyncImageView.swift
//  MoviesDB N-6
//
//  Created by Zuka Papuashvili on 07.06.24.
//

import SwiftUI

struct AsyncImageView: View {
    let url: URL?

    var body: some View {
        Group {
            if let url = url {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray
                }
                .clipped()
            } else {
                Color.gray
            }
        }
    }
}

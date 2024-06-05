//
//  ListItemView.swift
//  SwiftUI Exercise N-1
//
//  Created by Zuka Papuashvili on 23.05.24.
//

import SwiftUI

struct ListItemView: View {
    var item: ListItem
    
    var body: some View {
        HStack {
            Image("cellImage")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
                .padding(.leading, 16)
            VStack(alignment: .leading, spacing: 5) {
                Text(item.title)
                    .foregroundColor(.white)
                Text(item.subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 16)
            .padding(.leading, 16)
            .padding(.trailing, 16)
            Spacer()
        }
        .alignmentGuide(.listRowSeparatorLeading) { d in
            d[.leading]
        }
        .alignmentGuide(.listRowSeparatorTrailing) { d in
            d[.trailing]
        }
    }
}

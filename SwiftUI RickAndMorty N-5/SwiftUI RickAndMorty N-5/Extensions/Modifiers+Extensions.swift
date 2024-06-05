//
//  Modifiers+Extensions.swift
//  SwiftUI RickAndMorty N-5
//
//  Created by Zuka Papuashvili on 31.05.24.
//

import SwiftUI

struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color(.systemGray6))
            .cornerRadius(15)
            .shadow(radius: 10)
            .padding(.horizontal)
            .padding(.vertical, 5)
    }
}

extension View {
    func cardStyle() -> some View {
        self.modifier(CardStyle())
    }
}

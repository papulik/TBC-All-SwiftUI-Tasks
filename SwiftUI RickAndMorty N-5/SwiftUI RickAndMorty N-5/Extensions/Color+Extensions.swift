//
//  Color+Extensions.swift
//  SwiftUI RickAndMorty N-5
//
//  Created by Zuka Papuashvili on 31.05.24.
//

import SwiftUI

extension Color {
    static let newBlue = Color("CustomBlue")
    static let newPurple = Color("CustomPurple")
    static let customGradient = LinearGradient(
        gradient: Gradient(colors: [.customBlue, .customPurple]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

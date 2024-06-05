//
//  NavigationBarVisual.swift
//  SwiftUI RickAndMorty N-5
//
//  Created by Zuka Papuashvili on 31.05.24.
//

import SwiftUI

func setupNavigationBarAppearance() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithTransparentBackground()
    appearance.backgroundColor = .clear
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
}


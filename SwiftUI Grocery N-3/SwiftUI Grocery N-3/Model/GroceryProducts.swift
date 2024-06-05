//
//  GroceryProducts.swift
//  SwiftUI Grocery N-3
//
//  Created by Zuka Papuashvili on 25.05.24.
//

import Foundation

//MARK: - Products Model
struct Product: Identifiable {
    let id = UUID()
    var name: String
    var price: Double
    var imageName: String
    var quantity: Int
    var inStock: Bool
}

//
//  ContentViewViewModel.swift
//  SwiftUI Grocery N-3
//
//  Created by Zuka Papuashvili on 25.05.24.
//

import Foundation

//MARK: - Grocery ViewModel
final class ContentViewViewModel: ObservableObject {
    @Published var products: [Product] = [
        Product(name: "Apple", price: 1.1, imageName: "Apple", quantity: 0, inStock: true),
        Product(name: "Banana", price: 3.80, imageName: "Banana", quantity: 0, inStock: true),
        Product(name: "Carrot", price: 0.9, imageName: "Carrot", quantity: 0, inStock: false),
        Product(name: "Orange", price: 1.7, imageName: "Orange", quantity: 0, inStock: true),
        Product(name: "Ananas", price: 12.3, imageName: "Ananas", quantity: 0, inStock: true),
        Product(name: "Cherry", price: 0.45, imageName: "Cherry", quantity: 0, inStock: false),
        Product(name: "Cucumber", price: 0.45, imageName: "Cucumber", quantity: 0, inStock: false),
        Product(name: "Avocado", price: 6.45, imageName: "Avocado", quantity: 0, inStock: true),
        Product(name: "Melon", price: 13.45, imageName: "Melon", quantity: 0, inStock: false),
        Product(name: "WaterMelon", price: 17.45, imageName: "WaterMelon", quantity: 0, inStock: true),
        Product(name: "Tomato", price: 0.8, imageName: "Tomato", quantity: 0, inStock: true),
    ]
    
    @Published var discountApplied = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    var totalQuantity: Int {
        products.reduce(0) { $0 + $1.quantity }
    }
    
    var totalPrice: Double {
        products.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
    }
    
    func increaseQuantity(of product: Product) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products[index].quantity += 1
        }
    }
    
    func decreaseQuantity(of product: Product) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            if products[index].quantity > 0 {
                products[index].quantity -= 1
            }
        }
    }
    
    func deleteProduct(_ product: Product) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products.remove(at: index)
        }
    }
    
    func applyDiscount(_ discount: Double) -> Bool {
        if discountApplied { return false }
        
        for index in products.indices {
            products[index].price *= (1 - discount)
        }
        
        discountApplied = true
        return true
    }
}

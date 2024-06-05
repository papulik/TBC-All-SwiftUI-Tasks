//
//  ContentView.swift
//  SwiftUI Grocery N-3
//
//  Created by Zuka Papuashvili on 25.05.24.
//

import SwiftUI

// MARK: - Main View
struct ContentView: View {
    
    @StateObject var viewModel = ContentViewViewModel()
    
    var body: some View {
        VStack {
            HeaderView()
            
            ScrollView {
                ForEach(viewModel.products) { product in
                    ProductCell(product: product)
                        .opacity(product.inStock ? 1 : 0.5)
                }
            }
            
            FooterView()
        }
        .padding()
        .background(Color(UIColor.systemMint).opacity(0.3))
        .environmentObject(viewModel)
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}

//
//  ProductCell.swift
//  SwiftUI Grocery N-3
//
//  Created by Zuka Papuashvili on 27.05.24.
//

import SwiftUI

// MARK: - Cell
struct ProductCell: View {
    var product: Product
    @EnvironmentObject var viewModel: ContentViewViewModel
    
    var body: some View {
        HStack {
            productImage
            productDetails
            Spacer()
            quantityAdjuster
            deleteButton
        }
        .padding()
        .background(Color(uiColor: .systemGray6))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
        .padding(.vertical, 5)
    }
    
    private var productImage: some View {
        Image(product.imageName)
            .resizable()
            .frame(width: 50, height: 50)
            .cornerRadius(8)
            .padding(.trailing, 10)
    }
    
    private var productDetails: some View {
        VStack(alignment: .leading) {
            Text(product.name)
                .font(.headline)
            Text("₾ \(product.price, specifier: "%.2f")")
        }
    }
    
    private var quantityAdjuster: some View {
        HStack {
            Button(action: {
                viewModel.decreaseQuantity(of: product)
            }) {
                Image(systemName: "minus.circle")
                    .foregroundColor(.primary)
            }
            .disabled(!product.inStock)
            Text("\(product.quantity)")
            Button(action: {
                viewModel.increaseQuantity(of: product)
            }) {
                Image(systemName: "plus.circle")
                    .foregroundColor(.primary)
            }
            .disabled(!product.inStock)
        }
        .padding(.horizontal, 10)
    }
    
    private var deleteButton: some View {
        Button(action: {
            viewModel.deleteProduct(product)
        }) {
            Image(systemName: "trash")
                .foregroundColor(.primary)
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}

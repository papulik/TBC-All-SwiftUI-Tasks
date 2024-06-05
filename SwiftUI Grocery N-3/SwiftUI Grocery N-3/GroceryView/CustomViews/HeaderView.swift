//
//  HeaderView.swift
//  SwiftUI Grocery N-3
//
//  Created by Zuka Papuashvili on 27.05.24.
//

import SwiftUI

// MARK: - Header
struct HeaderView: View {
    @EnvironmentObject var viewModel: ContentViewViewModel
    
    var body: some View {
        VStack {
            headerTitle
            headerImage
        }
        .padding()
    }
    
    private var headerTitle: some View {
        HStack {
            Text("Groceries Cart")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            cartIcon
        }
        .padding(.horizontal)
    }
    
    private var headerImage: some View {
        Image("Groceries")
            .resizable()
            .scaledToFit()
            .frame(height: 140)
            .padding(.horizontal)
    }
    
    private var cartIcon: some View {
        ZStack {
            Image(systemName: "cart")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
            if viewModel.totalQuantity > 0 {
                Circle()
                    .foregroundColor(.red)
                    .frame(width: 20, height: 20)
                    .overlay(
                        Text("\(viewModel.totalQuantity)")
                            .foregroundColor(.white)
                            .font(.caption)
                    )
                    .offset(x: 10, y: -10)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}

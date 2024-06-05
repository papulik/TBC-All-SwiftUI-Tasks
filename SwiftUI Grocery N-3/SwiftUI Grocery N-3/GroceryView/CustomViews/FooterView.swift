//
//  FooterView.swift
//  SwiftUI Grocery N-3
//
//  Created by Zuka Papuashvili on 27.05.24.
//

import SwiftUI

// MARK: - Footer
struct FooterView: View {
    @EnvironmentObject var viewModel: ContentViewViewModel
    
    var body: some View {
        VStack(spacing: 15) {
            footerDetails
            paymentButton
        }
        .padding()
        .background(Color(uiColor: .systemGray6))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 5)
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Discount Status"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private var footerDetails: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Total Quantity")
                    .font(.caption)
                Text("\(viewModel.totalQuantity)")
                    .font(.headline)
                    .padding(.bottom, 7)
                Text("Total Price")
                    .font(.caption)
                Text("₾ \(viewModel.totalPrice, specifier: "%.2f")")
                    .font(.headline)
            }
            Spacer()
            discountButton
        }
        .padding(.horizontal)
    }
    
    private var discountButton: some View {
        Button(action: {
            if viewModel.applyDiscount(0.2) {
                viewModel.alertMessage = "You have successfully applied the discount. ✅🎉"
            } else {
                viewModel.alertMessage = "🚨 Sorry, you have already used the discount. 🧐🤌"
            }
            viewModel.showAlert = true
        }) {
            Text("Apply 20% Discount")
                .font(.headline)
                .foregroundColor(.primary)
                .padding()
                .background(Color.discountColoring)
                .cornerRadius(10)
        }
    }
    
    private var paymentButton: some View {
        Button(action: {
            if let url = URL(string: "https://www.google.com") {
                UIApplication.shared.open(url)
            }
        }) {
            HStack {
                Text("Payment")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "creditcard")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.primary)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green.opacity(0.6))
            .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}

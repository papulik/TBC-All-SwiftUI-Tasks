//
//  TransportView.swift
//  SwiftUI TravelTip N-4
//
//  Created by Zuka Papuashvili on 29.05.24.
//

import SwiftUI

struct TransportView: View {
    @StateObject private var viewModel: TransportViewModel
    @Binding var navigationPath: [TripInfo]
    
    init(destination: TripInfo, navigationPath: Binding<[TripInfo]>) {
        _viewModel = StateObject(wrappedValue: TransportViewModel(destination: destination))
        _navigationPath = navigationPath
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            transportImage
            transportHeader
            transportOptions
            Spacer()
        }
        .padding()
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 5)
        .padding()
        .navigationTitle("Transport")
        .background(backgroundGradient)
        .transition(.slide)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    navigationPath.removeAll()
                }) {
                    Text("Main Page")
                        .foregroundColor(.blue)
                }
            }
        }
        .onAppear {
            animateView()
        }
    }
    
    private var transportImage: some View {
        Image("transport")
            .resizable()
            .scaledToFill()
            .frame(height: 200)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
            .padding(.bottom, 20)
            .opacity(viewModel.imageOpacity)
            .scaleEffect(viewModel.imageScale)
    }
    
    private var transportHeader: some View {
        Text("Transport options in \(viewModel.destination.name)")
            .font(.title2)
            .fontWeight(.bold)
            .padding(.bottom, 10)
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: true)
            .opacity(viewModel.headerOpacity)
            .scaleEffect(viewModel.headerScale)
    }
    
    private var transportOptions: some View {
        ForEach(viewModel.destination.transportOptions, id: \.self) { option in
            Text(option)
                .font(.headline)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    private var backgroundGradient: some View {
        LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.3), Color.purple.opacity(0.3)]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
    }
    
    private func animateView() {
        withAnimation(.easeIn(duration: 0.5)) {
            viewModel.imageOpacity = 1
            viewModel.imageScale = 1
        }
        withAnimation(.easeIn(duration: 0.7)) {
            viewModel.headerOpacity = 1
            viewModel.headerScale = 1
        }
    }
}

#Preview {
    TransportView(
        destination: TripInfo(
            id: "4",
            name: "Tbilisi",
            description: "Hello World!",
            country: "Georgia",
            region: "Racha",
            population: 300000,
            nationality: "Georgian",
            imageName: "rio",
            transportOptions: [
                "Taxis: Widely available and convenient for short trips.",
                "Buses: Affordable and cover most areas.",
                "Rental Cars: Available at the airport and major locations.",
                "Bicycles: Many rental shops available for exploring the area."
            ],
            sightseeingAttractions: [
                "Taxis: Widely available and convenient for short trips.",
                "Buses: Affordable and cover most areas.",
                "Rental Cars: Available at the airport and major locations.",
                "Bicycles: Many rental shops available for exploring the area."
            ],
            hotels: [
                "Taxis: Widely available and convenient for short trips.",
                "Buses: Affordable and cover most areas.",
                "Rental Cars: Available at the airport and major locations.",
                "Bicycles: Many rental shops available for exploring the area."
            ]
        ),
        navigationPath: .constant([])
    )
}


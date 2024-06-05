//
//  MustSeeView.swift
//  SwiftUI TravelTip N-4
//
//  Created by Zuka Papuashvili on 29.05.24.
//

import SwiftUI

struct MustSeeView: View {
    @StateObject private var viewModel: MustSeeViewModel
    @Binding var navigationPath: [TripInfo]
    
    init(destination: TripInfo, navigationPath: Binding<[TripInfo]>) {
        _viewModel = StateObject(wrappedValue: MustSeeViewModel(destination: destination))
        _navigationPath = navigationPath
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            mustSeeImage
            mustSeeHeader
            mustSeeAttractions
            Spacer()
        }
        .padding()
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 5)
        .padding()
        .navigationTitle("Must See")
        .background(backgroundGradient)
        .transition(.opacity)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    navigationPath.removeAll()  // Reset the navigation path
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
    
    private var mustSeeImage: some View {
        Image("mustsee")
            .resizable()
            .scaledToFill()
            .frame(height: 200)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
            .padding(.bottom, 20)
            .offset(y: viewModel.imageOffset)
    }
    
    private var mustSeeHeader: some View {
        Text("Must see attractions in \(viewModel.destination.name)")
            .font(.title2)
            .fontWeight(.bold)
            .padding(.bottom, 10)
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: true)
            .offset(y: viewModel.headerOffset)
    }
    
    private var mustSeeAttractions: some View {
        ForEach(viewModel.destination.sightseeingAttractions.indices, id: \.self) { index in
            Text(viewModel.destination.sightseeingAttractions[index])
                .font(.headline)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .offset(y: viewModel.attractionsOffset[index])
        }
    }
    
    private var backgroundGradient: some View {
        LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.3), Color.yellow.opacity(0.3)]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
    }
    
    private func animateView() {
        withAnimation(.easeOut(duration: 0.5)) {
            viewModel.imageOffset = 0
        }
        withAnimation(.easeOut(duration: 0.6)) {
            viewModel.headerOffset = 0
        }
        for index in viewModel.destination.sightseeingAttractions.indices {
            withAnimation(.easeOut(duration: 0.5).delay(0.2 * Double(index))) {
                viewModel.attractionsOffset[index] = 0
            }
        }
    }
}

#Preview {
    MustSeeView(
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


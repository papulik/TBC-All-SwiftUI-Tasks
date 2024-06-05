//
//  HotelsView.swift
//  SwiftUI TravelTip N-4
//
//  Created by Zuka Papuashvili on 29.05.24.
//

import SwiftUI

struct HotelsView: View {
    @StateObject private var viewModel: HotelsViewModel
    @Binding var navigationPath: [TripInfo]
    
    init(destination: TripInfo, navigationPath: Binding<[TripInfo]>) {
        _viewModel = StateObject(wrappedValue: HotelsViewModel(destination: destination))
        _navigationPath = navigationPath
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            hotelsImage
            hotelsHeader
            hotelsList
            Spacer()
        }
        .padding()
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 5)
        .padding()
        .navigationTitle("Hotels")
        .background(backgroundGradient)
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
    
    private var hotelsImage: some View {
        Image("hotels")
            .resizable()
            .scaledToFill()
            .frame(height: 200)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
            .padding(.bottom, 20)
            .opacity(viewModel.imageOpacity)
    }
    
    private var hotelsHeader: some View {
        Text("Hotels in \(viewModel.destination.name)")
            .font(.title2)
            .fontWeight(.bold)
            .padding(.bottom, 10)
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: true)
            .opacity(viewModel.headerOpacity)
    }
    
    private var hotelsList: some View {
        ForEach(viewModel.destination.hotels.indices, id: \.self) { index in
            Text(viewModel.destination.hotels[index])
                .font(.headline)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .opacity(viewModel.hotelsOpacity[index])
        }
    }
    
    private var backgroundGradient: some View {
        LinearGradient(gradient: Gradient(colors: [Color.red.opacity(0.3), Color.orange.opacity(0.3)]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
    }
    
    private func animateView() {
        withAnimation(.easeIn(duration: 0.5)) {
            viewModel.imageOpacity = 1
        }
        withAnimation(.easeIn(duration: 0.6)) {
            viewModel.headerOpacity = 1
        }
        for index in viewModel.destination.hotels.indices {
            withAnimation(.easeIn(duration: 0.5).delay(0.2 * Double(index))) {
                viewModel.hotelsOpacity[index] = 1
            }
        }
    }
}

#Preview {
    HotelsView(
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

//
//  DestinationDetailScreen.swift
//  SwiftUI TravelTip N-4
//
//  Created by Zuka Papuashvili on 29.05.24.
//

import SwiftUI

struct DestinationDetailScreen: View {
    @StateObject private var viewModel: DestinationDetailViewViewModel
    @Binding var navigationPath: [TripInfo]    
    init(destination: TripInfo, navigationPath: Binding<[TripInfo]>) {
        _viewModel = StateObject(wrappedValue: DestinationDetailViewViewModel(destination: destination))
        _navigationPath = navigationPath
        UINavigationBar.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack {
            destinationImage
            ScrollView {
                textSection
                buttonSection
            }
        }
        .navigationTitle(viewModel.destination.name)
        .background(backgroundGradient)
        .onAppear {
            withAnimation(.easeIn(duration: 0.5)) {
                viewModel.imageOpacity = 1
                viewModel.imageScale = 1
            }
        }
    }
    
    private var destinationImage: some View {
        Image(viewModel.destination.imageName)
            .resizable()
            .scaledToFit()
            .frame(height: 300)
            .clipped()
            .opacity(viewModel.imageOpacity)
            .scaleEffect(viewModel.imageScale)
    }
    
    private var textSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(viewModel.destination.description)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            
            infoText("Population", value: "\(viewModel.destination.population)")
            infoText("Country", value: viewModel.destination.country)
            infoText("Region", value: viewModel.destination.region)
            infoText("Nationality", value: viewModel.destination.nationality)
        }
        .padding()
        .background(Color.blue.opacity(0.4))
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
    }
    
    private func infoText(_ title: String, value: String) -> some View {
        HStack {
            Text("\(title):")
                .font(.headline)
                .foregroundColor(.primary)
            Text(value)
                .font(.body)
                .foregroundColor(.primary)
        }
    }
    
    private var buttonSection: some View {
        HStack(spacing: 20) {
            NavigationLink(destination: TransportView(destination: viewModel.destination, navigationPath: $navigationPath)) {
                DestinationButton(iconName: "car.fill", color: .purple)
            }
            
            NavigationLink(destination: MustSeeView(destination: viewModel.destination, navigationPath: $navigationPath)) {
                DestinationButton(iconName: "map.fill", color: .green)
            }
            
            NavigationLink(destination: HotelsView(destination: viewModel.destination, navigationPath: $navigationPath)) {
                DestinationButton(iconName: "house.fill", color: .red)
            }
        }
        .padding(.horizontal)
    }
    
    private var backgroundGradient: some View {
        LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.3), Color.blue.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    DestinationDetailScreen(destination: TripInfo(
        id: "1",
        name: "Bali",
        description: "Beautiful island in Indonesia with a rich cultural heritage and stunning landscapes.",
        country: "Indonesia",
        region: "Southeast Asia",
        population: 4321432,
        nationality: "Balinese",
        imageName: "rio",
        transportOptions: [
            "Taxis: Widely available and convenient for short trips.",
            "Buses: Affordable and cover most areas.",
            "Rental Cars: Available at the airport and major locations.",
            "Bicycles: Many rental shops available for exploring the area."
        ],
        sightseeingAttractions: [
            "Uluwatu Temple: A beautiful sea temple with stunning sunset views.",
            "Tegallalang Rice Terraces: Famous for its terraced layout and scenic beauty.",
            "Ubud Monkey Forest: A sanctuary for Balinese long-tailed monkeys.",
            "Mount Batur: Popular for hiking and its breathtaking sunrise view."
        ],
        hotels: [
            "The Mulia: Luxury beachfront resort with stunning views.",
            "Four Seasons Resort: Offers private villas with top-notch amenities.",
            "Ayana Resort and Spa: Famous for its rock bar and ocean views.",
            "W Bali - Seminyak: Trendy hotel with vibrant nightlife."
        ]
    ), navigationPath: .constant([]))
}

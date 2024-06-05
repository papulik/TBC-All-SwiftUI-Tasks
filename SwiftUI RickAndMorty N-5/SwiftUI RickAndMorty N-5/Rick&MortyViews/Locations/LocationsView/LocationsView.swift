//
//  LocationsView.swift
//  SwiftUI RickAndMorty N-5
//
//  Created by Zuka Papuashvili on 31.05.24.
//

import SwiftUI

struct LocationsView: View {
    @StateObject private var viewModel = LocationsViewModel()

    init() {
        setupNavigationBarAppearance()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundView
                content
            }
            .navigationTitle("Locations")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.fetchLocations()
        }
    }

    private var backgroundView: some View {
        Color.customGradient.ignoresSafeArea()
    }

    private var content: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                ForEach(viewModel.locations.indices, id: \.self) { index in
                    locationCell(for: viewModel.locations[index], index: index)
                }
            }
            .padding()
        }
    }

    private func locationCell(for location: Location, index: Int) -> some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .center) {
                Text(location.name)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
                    .padding(.horizontal)
                    .padding(.top, 10)
                
                Spacer()
                
                Text(location.type)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.horizontal)
                
                Text(location.dimension)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
            }
            .padding()
            .frame(width: 150, height: 150)
            .background(
                Image(viewModel.getImageName(for: index))
                    .resizable()
                    .scaledToFill()
                    .opacity(0.6)
            )
            .background(Color.elementColors.opacity(0.3))
            .cornerRadius(15)
            .shadow(radius: 10)
        }
    }
}

#Preview {
    LocationsView()
}

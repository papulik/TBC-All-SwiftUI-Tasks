//
//  MainScreenView.swift
//  SwiftUI TravelTip N-4
//
//  Created by Zuka Papuashvili on 29.05.24.
//

import SwiftUI

struct MainScreenView: View {
    @StateObject private var viewModel = DestinationViewModel()
    @State private var navigationPath: [TripInfo] = []
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                backgroundGradient
                mainContent
            }
            .toolbar {
                travelTipsText
                travelTipsButton
            }
            .onAppear {
                viewModel.loadDestinations()
            }
            .alert(isPresented: $viewModel.showingAlert) {
                travelTipAlert
            }
            .navigationDestination(for: TripInfo.self) { destination in
                DestinationDetailScreen(destination: destination, navigationPath: $navigationPath)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    private var backgroundGradient: some View {
        LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.green.opacity(0.3)]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
    }
    
    private var mainContent: some View {
        VStack {
            header
            destinationList
        }
    }
    
    private var header: some View {
        Text("Travel Destinations")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.primary)
            .padding(.top, 25)
            .padding(.trailing, 50)
    }
    
    private var destinationList: some View {
        List(viewModel.destinations) { destination in
            Button {
                navigationPath.append(destination)
            } label: {
                DestinationCardView(destination: destination)
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
        .background(Color.clear)
    }
    
    private var travelTipsText: some View {
        Text("Tips")
            .font(.title2)
            .fontWeight(.bold)
    }
    
    private var travelTipsButton: some View {
        Button(action: viewModel.showTravelTips) {
            Image(systemName: "questionmark.bubble.fill")
                .font(.title)
                .foregroundColor(.red)
        }.padding(.trailing, 20)
    }
    
    private var travelTipAlert: Alert {
        Alert(title: Text("Travel Tip"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
    }
}

#Preview {
    MainScreenView()
}

//
//  DestinationCardView.swift
//  SwiftUI TravelTip N-4
//
//  Created by Zuka Papuashvili on 30.05.24.
//

import SwiftUI

struct DestinationCardView: View {
    var destination: TripInfo
    
    var body: some View {
        HStack {
            Image(destination.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipped()
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(destination.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(destination.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading, 10)
        }
        .padding()
        .background(Color.white.opacity(0.7))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    MainScreenView()
}

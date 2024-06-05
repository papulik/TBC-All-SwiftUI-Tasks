//
//  DestinationButton.swift
//  SwiftUI TravelTip N-4
//
//  Created by Zuka Papuashvili on 30.05.24.
//

import SwiftUI

struct DestinationButton: View {
    var iconName: String
    var color: Color
    
    var body: some View {
        Image(systemName: iconName)
            .font(.largeTitle)
            .padding()
            .frame(maxWidth: .infinity)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(color: color.opacity(0.5), radius: 5, x: 0, y: 5)
    }
}

//
//  ChatView.swift
//  SwiftUI Exercise N-1
//
//  Created by Zuka Papuashvili on 23.05.24.
//

import SwiftUI

struct ChatView: View {
    var imageName: String
    var title: String
    @Binding var backgroundColor: Color
    var action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                action()
            }) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .padding(.top, 10)
                    .padding(.leading, 10)
            }
            Text(title)
                .multilineTextAlignment(.leading)
                .padding([.leading, .trailing, .bottom], 10)
                .foregroundColor(.white)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(backgroundColor)
        .cornerRadius(10)
        .shadow(radius: 5)
        .overlay(
            Image("chattingImage")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 90)
                .padding([.bottom, .trailing], 0),
            alignment: .bottomTrailing
        )
    }
}

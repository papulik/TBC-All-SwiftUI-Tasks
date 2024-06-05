//
//  GuitarView.swift
//  SwiftUI Exercise N-1
//
//  Created by Zuka Papuashvili on 23.05.24.
//

import SwiftUI

struct GuitarView: View {
    var imageName: String
    var title: String
    @State var subtitle: String
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Button(action: {
                    subtitle = (subtitle == "We love property wrappers and closures") ? "მაგარია სვიფტ უაიი." : "We love property wrappers and closures"
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
                Text(subtitle)
                    .multilineTextAlignment(.leading)
                    .padding([.leading, .trailing], 10)
                    .foregroundColor(.white)
                    .lineSpacing(10.0)
                    .font(.headline)
                    .padding(.trailing, 20)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(alignment: .bottomTrailing) {
                Image("guitarImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 150)
            }
            .background(Color.yellow)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


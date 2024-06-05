//
//  CustomProgressViewStyle.swift
//  SwiftUI Exercise N-2
//
//  Created by Zuka Papuashvili on 24.05.24.
//

import SwiftUI

struct CustomProgressViewStyle: ProgressViewStyle {
    var strokeColor = Color.progressColoring
    var strokeWidth = 20.0

    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: strokeWidth / 2)
                    .frame(height: strokeWidth)
                    .foregroundColor(strokeColor.opacity(0.4))
                RoundedRectangle(cornerRadius: strokeWidth / 2)
                    .frame(width: (configuration.fractionCompleted ?? 0) * geometry.size.width, height: strokeWidth)
                    .foregroundColor(strokeColor)
            }
        }
        .frame(height: strokeWidth)
    }
}

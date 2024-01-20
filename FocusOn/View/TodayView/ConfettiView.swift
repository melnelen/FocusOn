//
//  ConfettiView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 23/10/2023.
//

import SwiftUI

struct ConfettiView: View {
    var body: some View {
        ZStack {
            ForEach(0..<30) { _ in
                ConfettiParticle()
            }
        }
    }
}

private struct ConfettiParticle: View {
    @State private var xOffset = CGFloat.random(in: -10...10)
    @State private var yOffset = CGFloat.random(in: 0...100)
    @State private var rotation = Angle.degrees(Double.random(in: -30...30))

    var body: some View {
        Image(systemName: "sparkles")
            .font(.system(size: 15))
            .foregroundColor(.randomColor())
            .offset(x: xOffset, y: yOffset)
            .rotationEffect(rotation)
            .animation(
                Animation
                    .easeInOut(duration: Double.random(in: 0.5...1.5))
                    .repeatForever(autoreverses: false)
            )
            .onAppear {
                xOffset = CGFloat.random(in: -100...100)
                yOffset = CGFloat.random(in: -600...0)
                rotation = Angle.degrees(Double.random(in: -30...30))
            }
    }
}

extension Color {
    static func randomColor() -> Color {
        return Color(red: Double.random(in: 0.5...1.0), green: Double.random(in: 0.5...1.0), blue: Double.random(in: 0.0...0.5))
    }
}

#Preview {
    ConfettiView()
}

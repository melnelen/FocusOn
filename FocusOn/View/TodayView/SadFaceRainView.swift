//
//  SadFaceRainView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 20/01/2024.
//

import SwiftUI

struct SadFaceRainView: View {
    var body: some View {
        ZStack {
            ForEach(0..<30) { _ in
                SadFaceParticle()
            }
        }
    }
}

private struct SadFaceParticle: View {
    @State private var xOffset = CGFloat.random(in: -200...200)
    @State private var yOffset = CGFloat.random(in: -300...0)

    var body: some View {
        Text("😢")
            .font(.system(size: 15))
            .foregroundColor(.randomColor())
            .offset(x: xOffset, y: yOffset)
            .animation(
                Animation
                    .easeInOut(duration: Double.random(in: 0.5...10.0))
                    .repeatForever(autoreverses: false)
            )
            .onAppear {
                xOffset = CGFloat.random(in: -200...200)
                yOffset = CGFloat.random(in: 100...600)
            }
    }
}

#Preview {
    SadFaceRainView()
}

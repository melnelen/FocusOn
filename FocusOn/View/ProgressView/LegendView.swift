//
//  LegendView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 18/01/2024.
//

import SwiftUI

struct LegendView: View {
    var body: some View {
        Text("Legend:")
            .foregroundColor(.accentColor)
            .font(.headline)
            .padding()
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                HStack {
                    Circle()
                        .fill(Color("AlternateColor"))
                        .frame(width: 14, height: 14)
                        .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 2)
                        )
                    Text("No Goal")
                }
                HStack {
                    Circle()
                        .fill(Color("FailColor"))
                        .frame(width: 16, height: 16)
                    Text("Fail")
                }
                HStack {
                    Circle()
                        .fill(Color("ProgressColor"))
                        .frame(width: 16, height: 16)
                    Text("Small Progress")
                }
            }
            .padding()
            VStack(alignment: .leading) {
                HStack {
                    Circle()
                        .fill(Color("AccentColor"))
                        .frame(width: 16, height: 16)
                    Text("Big Progress")
                }
                HStack {
                    Circle()
                        .fill(Color("SuccessColor"))
                        .frame(width: 16, height: 16)
                    Text("Success")
                }
                
            }
            .padding()
        }
    }
}

#Preview {
    LegendView()
}

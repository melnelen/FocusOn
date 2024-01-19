//
//  NoGoalsView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 19/01/2024.
//

import SwiftUI

struct NoGoalsView: View {
    var body: some View {
        VStack {
            Image(systemName: "text.badge.xmark")
                .font(.system(size: 50, weight: .bold))
                .foregroundColor(Color("FailColor"))
                .padding(.bottom)
            Text("You have not worked on any goals yet.")
        }
    }
}

#Preview {
    NoGoalsView()
}

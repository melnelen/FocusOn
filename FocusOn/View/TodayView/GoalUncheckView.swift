//
//  GoalUncheckView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 20/01/2024.
//

import SwiftUI

struct GoalUncheckView: View {
    var body: some View {
        Text("Don't give up!")
            .font(.title)
            .foregroundColor(.white)
            .padding(30)
            .background(Color("FailColor"))
            .cornerRadius(100)
        SadFaceRainView()
    }
}

#Preview {
    GoalUncheckView()
}

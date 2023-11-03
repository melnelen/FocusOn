//
//  GoalCompletionView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 24/10/2023.
//

import SwiftUI

struct GoalCompletionView: View {
    var body: some View {
        Text("Amazing! Goal Completed!")
            .font(.title)
            .foregroundColor(.white)
            .padding(30)
            .background(Color("SuccessColor"))
            .cornerRadius(100)
        ConfettiView()
    }
}

struct GoalCompletionView_Previews: PreviewProvider {
    static var previews: some View {
        GoalCompletionView()
    }
}

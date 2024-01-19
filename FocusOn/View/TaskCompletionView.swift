//
//  TaskCompletionView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 23/10/2023.
//

import SwiftUI

struct TaskCompletionView: View {
    var body: some View {
        Text("Great job on making progress!")
            .font(.title)
            .foregroundColor(.white)
            .padding(30)
            .background(Color("AccentColor"))
            .cornerRadius(100)
    }
}

#Preview {
    TaskCompletionView()
}

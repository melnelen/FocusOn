//
//  TaskCompletionView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 23/10/2023.
//

import SwiftUI

struct TaskCompletionView: View {
    var body: some View {
        Text("Great! Task Completed!")
            .font(.title)
            .foregroundColor(.white)
            .padding(30)
            .background(Color("AccentColor"))
            .cornerRadius(100)
    }
}

struct TaskCompletionView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCompletionView()
    }
}

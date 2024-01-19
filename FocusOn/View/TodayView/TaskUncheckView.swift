//
//  TaskUncheckingView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 02/12/2023.
//

import SwiftUI

struct TaskUncheckView: View {
    var body: some View {
        Text("Ah, no biggie, you’ll get it next time!")
            .font(.title)
            .foregroundColor(.white)
            .padding(30)
            .background(Color("FailColor"))
            .cornerRadius(100)
    }
}

struct TaskUncheckView_Previews: PreviewProvider {
    static var previews: some View {
        TaskUncheckView()
    }
}

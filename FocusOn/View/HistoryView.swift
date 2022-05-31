//
//  HistoryView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 06/02/2022.
//

import SwiftUI

struct HistoryView: View {
    //    @EnvironmentObject private var viewModel: HistoryViewModel
    @StateObject var viewModel = HistoryViewModel()
    
    @State private var completedGoals: [Goal]?
    
    var body: some View {
        Section {
            if let goals = completedGoals {
                Text("Goals you have completed.")
            } else {
                VStack {
                    Image(systemName: "text.badge.xmark")
                        .foregroundColor(Color("FailColor"))
                        .font(.system(size: 50, weight: .bold))
                        .padding(.bottom)
                    Text("Currently, you have not completed any goals.")
                }
            }
        }
        .onAppear { completedGoals = viewModel.allGoals }
    }
}

extension HistoryView {
    //    private func fetchCompletedGoals() {
    //        completedGoals = viewModel.fetchGoals()
    //    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
            .environmentObject(HistoryViewModel())
    }
}

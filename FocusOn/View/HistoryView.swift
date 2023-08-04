//
//  HistoryView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 06/02/2022.
//

import SwiftUI

struct HistoryView: View {
    @StateObject var viewModel = HistoryViewModel()
    
    @State private var allGoals: [Goal]?
    
    var body: some View {
        Section {
            if let goals = allGoals { // [Goal(), Goal(), Goal()]
                List {
                    ForEach(goals, id: \.self) { goal in
                        Section {
                            HStack {
                                Text(goal.name)
                                Spacer()
                                Image(systemName: (goal.isCompleted ? "checkmark.seal.fill" : "xmark.octagon.fill"))
                                    .foregroundColor(goal.isCompleted ? Color("SuccessColor") : Color("FailColor"))
                            }.font(.system(size: 25))
                            ForEach(Array(goal.tasks), id: \.self) { task in
                                HStack {
                                    Text(task.name)
                                    Spacer()
                                    Image(systemName: (task.isCompleted ? "checkmark.circle.fill" : "xmark.circle.fill"))
                                        .foregroundColor(task.isCompleted ? Color("SuccessColor") : Color("FailColor"))
                                }
                            }
                        } // header: { }
                    }
                }
            } else {
                VStack {
                    Image(systemName: "text.badge.xmark")
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(Color("FailColor"))
                        .padding(.bottom)
                    Text("You have not worked on any goals yet.")
                }
            }
        }
        .onAppear { fetchCompletedGoals() }
    }
}

extension HistoryView {
    private func fetchCompletedGoals() {
        allGoals = viewModel.fetchGoals()
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
            .environmentObject(HistoryViewModel())
    }
}

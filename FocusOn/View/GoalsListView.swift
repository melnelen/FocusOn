//
//  SwiftUIView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 19/01/2024.
//

import SwiftUI

struct GoalsListView: View {
    @ObservedObject var viewModel: HistoryViewModel
    
    var goal: Goal
    
    var body: some View {
        Section {
            // Goal with date
            HStack {
                LazyVStack (alignment: .leading) {
                    Text("\(viewModel.formattedGoalDate(from: goal.createdAt))")
                        .font(.caption)
                        .foregroundColor(Color.accentColor)
                    Text("\(goal.name)") // $goalNameText.wrappedValue
                        .font(.system(size: 25))
                }
                Spacer()
                // Goal completion icon
                Image(systemName: (goal.isCompleted ? "checkmark.seal.fill" : "xmark.octagon.fill"))
                    .foregroundColor(goal.isCompleted ? Color("SuccessColor") : Color("FailColor"))
            }.font(.system(size: 30))
            
            // Tasks
            ForEach(Array(goal.tasks), id: \.self) { task in
                HStack {
                    Text("\(task.name)")
                    Spacer()
                    // Task completion icon
                    Image(systemName: (task.isCompleted ? "checkmark.circle.fill" : "xmark.circle.fill"))
                        .foregroundColor(task.isCompleted ? Color("SuccessColor") : Color("FailColor"))
                }
            }
        }
    }
}

#Preview {
    GoalsListView(viewModel: HistoryView().viewModel,
                  goal: Goal(name: "Preview Goal 0",
                             createdAt: Date(),
                             tasks: [Task(name: "Preview task 0.1", isCompleted: true),
                                     Task(name: "Preview task 0.2", isCompleted: true),
                                     Task(name: "Preview task 0.3", isCompleted: true)]))
}

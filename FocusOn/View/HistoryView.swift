//
//  HistoryView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 06/02/2022.
//

import SwiftUI

struct HistoryView: View {
    @StateObject var viewModel = HistoryViewModel()
    
//    @State private var allGoals: [Goal]?
        
    var body: some View {
        NavigationView {
            Section {
                if let allGoals = viewModel.allGoals { // [Goal(), Goal(), Goal()]
                    List {
                        
                        // Monthly Summary
                        ForEach(viewModel.monthlySummaries.sorted(by: { $0.key < $1.key }), id: \.key) { (month, summary) in
                            LazyVStack {
                                // Monthly Summary header
                                Text("\(month)")
                                    .font(.title)
                                    .foregroundColor(Color.accentColor)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.vertical, 10)
                                // Monthly Summary details
                                Text("\(summary)")
                                    .font(.headline)
                                    .foregroundColor(Color.accentColor)
                                    .padding(.vertical, 5)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            
                            // Goals for the month
                            ForEach(viewModel.goalsForMonth(goals: allGoals, month: month), id: \.self) { goal in
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
                    }
                } else {
                    // No Goals Message
                    VStack {
                        Image(systemName: "text.badge.xmark")
                            .font(.system(size: 50, weight: .bold))
                            .foregroundColor(Color("FailColor"))
                            .padding(.bottom)
                        Text("You have not worked on any goals yet.")
                    }
                }
            }
            .navigationTitle("History")
            .onAppear { fetchGoals() }
        }
    }
}

extension HistoryView {
    private func fetchGoals() {
        viewModel.allGoals = viewModel.fetchGoals()
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
            .environmentObject(HistoryViewModel())
    }
}

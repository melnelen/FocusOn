//
//  HistoryView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 06/02/2022.
//

import SwiftUI

struct HistoryView: View {
    @StateObject var viewModel = HistoryViewModel()
            
    var body: some View {
        NavigationView {
            Section {
                if let allGoals = viewModel.allGoals, !allGoals.isEmpty { // [Goal(), Goal(), Goal()]
                    List {
                        
                        // Monthly Summary
                        ForEach(viewModel.monthlySummaries.sorted(by: { $0.key < $1.key }), id: \.key) { (month, summary) in
                            MonthlySummaryView(viewModel: viewModel, month: month, summary: summary)
                            
                            
                            // Goals for the month
                            ForEach(viewModel.goalsForMonth(goals: allGoals, month: month), id: \.self) { goal in
                                GoalsListView(viewModel: viewModel, goal: goal)
                            }
                        }
                    }
                } else {
                    NoGoalsView()
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

#Preview {
    HistoryView()
}

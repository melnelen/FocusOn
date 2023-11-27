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
            if allGoals != nil { // [Goal(), Goal(), Goal()]
                List {
                    
                    // Monthly Summary
                    ForEach(viewModel.monthlySummaries.sorted(by: { $0.key < $1.key }), id: \.key) { (month, summary) in
                        VStack {
                            Text("\(month)")
                                .font(.title)
                                .foregroundColor(Color("AccentColor"))
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, 10)
                            Text("\(summary)")
                                .font(.headline)
                                .foregroundColor(Color("AccentColor"))
                                .padding(.vertical, 5)
                                .fixedSize(horizontal: false, vertical: true)
                        }
        
                        // Goals for the month
                        ForEach((viewModel.allGoals?.filter { goal in
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "MMMM yyyy"
                            return dateFormatter.string(from: goal.createdAt) == month
                        } ?? []).sorted(by: { $0.createdAt > $1.createdAt }), id: \.self) { goal in
                            Section {
                                // Goal with date
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("\(formattedDate(from: goal.createdAt))")
                                            .font(.caption)
                                            .foregroundColor(Color("AccentColor"))
                                        Text("\(goal.name)")
                                            .font(.system(size: 25))
                                    }
                                        Spacer()
                                        Image(systemName: (goal.isCompleted ? "checkmark.seal.fill" : "xmark.octagon.fill"))
                                            .foregroundColor(goal.isCompleted ? Color("SuccessColor") : Color("FailColor"))
                                    }.font(.system(size: 30))
                                
                                // Tasks
                                ForEach(Array(goal.tasks), id: \.self) { task in
                                    HStack {
                                        Text("\(task.name)")
                                        Spacer()
                                        Image(systemName: (task.isCompleted ? "checkmark.circle.fill" : "xmark.circle.fill"))
                                            .foregroundColor(task.isCompleted ? Color("SuccessColor") : Color("FailColor"))
                                    }
                                }
                            }
                        }
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
    
    private func formattedDate(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: date)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
            .environmentObject(HistoryViewModel())
    }
}

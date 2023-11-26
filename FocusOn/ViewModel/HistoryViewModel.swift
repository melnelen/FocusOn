//
//  HistoryView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 30/05/2022.
//

import Foundation

class HistoryViewModel: ObservableObject {
    @Published var allGoals: [Goal]?
    @Published var monthlySummaries: [String: String] = [:]
    private let dataService: DataServiceProtocol
    
    init( dataService: DataServiceProtocol = MockDataService()) {
        self.dataService = dataService
        self.allGoals = dataService.allGoals
    }
    
    func fetchGoals() -> [Goal]? {
        allGoals = dataService.fetchGoals()
        calculateMonthlySummaries()
        return allGoals
    }
    
    private func calculateMonthlySummaries() {
            guard let goals = allGoals else { return }

            // Group goals by month
            let groupedGoals = Dictionary(grouping: goals) { goal in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMMM yyyy"
                return dateFormatter.string(from: goal.createdAt)
            }

            // Calculate summaries
            for (month, goals) in groupedGoals {
                let completedCount = goals.filter { $0.isCompleted }.count
                let totalCount = goals.count
                let summary = "\(completedCount) out of \(totalCount) goals completed"
                monthlySummaries[month] = summary
            }
        }
}

//
//  HistoryView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 30/05/2022.
//

import Foundation

class HistoryViewModel: ObservableObject {
    
    // MARK: Published Properties
    
    @Published var allGoals: [Goal]?
    @Published var monthlySummaries: [String: String] = [:]
    
    // MARK: Private Properties
    
    private let dataService: DataServiceProtocol
    private let summaryDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    private let goalDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()
    
    // MARK: Initializer
    
    init( dataService: DataServiceProtocol = DataService()) {
        self.dataService = dataService
        self.allGoals = dataService.allGoals
    }
    
    // MARK: Public Methods
    
    func fetchGoals() -> [Goal]? {
        dataService.fetchGoals()
        allGoals = dataService.allGoals
        calculateMonthlySummaries()
        return allGoals
    }
    
    func formattedGoalDate(from date: Date) -> String {
        return goalDateFormatter.string(from: date)
    }
    
    func goalsForMonth(goals: [Goal], month: String) -> [Goal] {
        let filteredGoals = goals.filter { goal in
            summaryDateFormatter.string(from: goal.createdAt) == month
        }
        return filteredGoals.sorted { $0.createdAt > $1.createdAt }
    }
    
    // MARK: Private Methods
    
    private func calculateMonthlySummaries() {
        guard let goals = allGoals else { return }
        
        // Group goals by month
        let groupedGoals = Dictionary(grouping: goals) { goal in
            return summaryDateFormatter.string(from: goal.createdAt)
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

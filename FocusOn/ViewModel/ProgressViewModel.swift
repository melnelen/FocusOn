//
//  ProgressViewModel.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 12/07/2023.
//

import Foundation
import SwiftUICharts
import SwiftUI

class ProgressViewModel: ObservableObject {
    @Published var allGoals: [Goal]?
    private let dataService: DataServiceProtocol
    let calendar = Calendar.current
    let firstWeekday = 2
    
    let noGoal = Legend(color: .gray, label: "No goal", order: 1)
    let fail = Legend(color: .red, label: "Fail", order: 2)
    let smallProgress = Legend(color: .orange, label: "Small Progress", order: 3)
    let bigProgress = Legend(color: .yellow, label: "Big Progress", order: 4)
    let success = Legend(color: .green, label: "Success", order: 5)
    
    init( dataService: DataServiceProtocol = MockDataService()) {
        self.dataService = dataService
        self.allGoals = dataService.allGoals
    }
    
    func fillChartData() -> [[DataPoint]]? {
        guard let unwrappedGoals = allGoals else {
            return nil
        }
        let weeklyChunksOfDataPoints = generateDataPointsForWeeklyChunksOf(goals: unwrappedGoals)
        
        return weeklyChunksOfDataPoints.isEmpty ? nil : weeklyChunksOfDataPoints
    }
    
    private func calculateNumberOfCompletedTasks(goal: Goal) -> Int {
        var numberOfCompletedTasks = 0
        
        for task in goal.tasks where task.isCompleted {
            numberOfCompletedTasks += 1
        }
        return numberOfCompletedTasks
    }
    
    private func calculateGoalProgress(goal: Goal) -> Legend {
        let legendSignature: Legend
        
        switch calculateNumberOfCompletedTasks(goal: goal) {
        case 0:
            legendSignature = fail
        case 1:
            legendSignature = smallProgress
        case 2:
            legendSignature = bigProgress
        case 3:
            legendSignature = success
        default:
            legendSignature = noGoal
        }
        return legendSignature
    }
    
    private func generateDataPointForGoal(goal: Goal) -> DataPoint {
        let barHight = Double(calculateNumberOfCompletedTasks(goal: goal) + 1)
        let dayComponent = Calendar.current.component(.day, from: goal.createdAt)
        let label = LocalizedStringKey(String(dayComponent))
        let legend = calculateGoalProgress(goal: goal)
        
        return DataPoint(value: barHight, label: label, legend: legend)
    }
    
    private func splitGoalsIntoWeeklyChunks(goals: [Goal]) -> [[Goal]] {
        let sortedGoals = goals.sorted { $0.createdAt < $1.createdAt }
        var goalChunks: [[Goal]] = []
        
        for goal in sortedGoals {
            let weekday = calendar.component(.weekday, from: goal.createdAt)
            if weekday == firstWeekday || goalChunks.isEmpty {
                goalChunks.append([goal])
            } else {
                goalChunks[goalChunks.count - 1].append(goal)
            }
        }
        return goalChunks
    }
    
    private func generateDataPointsForWeeklyChunksOf(goals: [Goal]) -> [[DataPoint]] {
        let goalChunks = splitGoalsIntoWeeklyChunks(goals: goals)
        var dataPointChunks: [[DataPoint]] = []

        for weeklyGoals in goalChunks {
            var dataPointsForWeek: [DataPoint] = []

            guard let earliestDate = weeklyGoals.map({ $0.createdAt }).min() else {
                continue
            }

            // Find the first Monday in the week
            let calendar = Calendar.current
            var components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear, .weekday], from: earliestDate)
            components.weekday = firstWeekday // Monday

            guard let firstMonday = calendar.date(from: components) else {
                continue
            }

            for i in 0..<7 {
                let currentDate = calendar.date(byAdding: .day, value: i, to: firstMonday) ?? Date()

                if let goal = weeklyGoals.first(where: { calendar.isDate($0.createdAt, inSameDayAs: currentDate) }) {
                    let dataPoint = generateDataPointForGoal(goal: goal)
                    dataPointsForWeek.append(dataPoint)
                } else {
                    let noGoalDataPoint = DataPoint(value: 0, label: "", legend: noGoal)
                    dataPointsForWeek.append(noGoalDataPoint)
                }
            }
            dataPointChunks.append(dataPointsForWeek)
        }
        return dataPointChunks
    }


    
}

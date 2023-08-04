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
    private var chartGoalsData: [DataPoint]
    private let dataService: DataServiceProtocol
    let calendar = Calendar.current
    
    let noGoal = Legend(color: .gray, label: "No goal", order: 1)
    let fail = Legend(color: .red, label: "Fail", order: 2)
    let smallProgress = Legend(color: .orange, label: "Small Progress", order: 3)
    let bigProgress = Legend(color: .yellow, label: "Big Progress", order: 4)
    let success = Legend(color: .green, label: "Success", order: 5)
    
    init( dataService: DataServiceProtocol = MockDataService()) {
        self.dataService = dataService
        self.allGoals = dataService.allGoals
        self.chartGoalsData = [DataPoint]() // FIX
    }
    
    func fillChartData() -> [DataPoint]? {
        guard let unwrappedGoals = allGoals else {
            return nil
        }
        var chartData: [DataPoint] = []

        for goal in unwrappedGoals {
            let completedTasksCount = Double(calculateNumberOfCompletedTasks(goal: goal))
            let dayComponent = Calendar.current.component(.day, from: goal.createdAt)
            let label = LocalizedStringKey(String(dayComponent))
            let legend = calculateGoalProgress(goal: goal)
            
            let dataPoint = DataPoint(value: completedTasksCount, label: label, legend: legend)
            chartData.append(dataPoint)
        }
        return chartData.isEmpty ? nil : chartData
    }

    
    func calculateNumberOfCompletedTasks(goal: Goal) -> Int {
        var numberOfCompletedTasks = 0
        
        for task in goal.tasks where task.isCompleted {
            numberOfCompletedTasks += 1
        }
        return numberOfCompletedTasks
    }
    
    func calculateGoalProgress(goal: Goal) -> Legend {
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
        
    /*
     for each goal take
     1. the number of tasks completed
     2. the day of the date the goal was created
     then generate the info for the legend:
     1. the color/label/order - depends of the -> 1. the number of tasks completed
     */
    /*
     DataPoint(value: 0,  // the nuber of tasks completed for this goal, determines the hight of the bar
     label: "1",          // the day of the date the goal was created
     legend: Legend(color: .red,    // the color of the label and the bar
     label: "Fail",  // the name of the label in the legend
     order: 1)       // the order of the label in the legend
     //
     let date = Goal.createdAt
     
     let calendar = Calendar.current
     let dayComponent = calendar.component(.day, from: date)
     //
     
     */
}

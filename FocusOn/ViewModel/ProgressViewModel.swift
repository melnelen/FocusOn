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
    @Published var chartData: [DataPoint]?
    private let dataService: DataServiceProtocol
    var chartGoalsData: [DataPoint]
    let calendar = Calendar.current
    
    let noGoal = Legend(color: .gray, label: "No goal", order: 1)
    let fail = Legend(color: .red, label: "Fail", order: 2)
    let smallProgress = Legend(color: .orange, label: "Small Progress", order: 3)
    let bigProgress = Legend(color: .yellow, label: "Big Progress", order: 4)
    let success = Legend(color: .green, label: "Success", order: 5)

    init( dataService: DataServiceProtocol = MockDataService()) {
        self.dataService = dataService
        self.allGoals = dataService.allGoals
        self.chartData = dataService.chartData // ??
        self.chartGoalsData = [DataPoint]() // ??
    }
    
    func fetchGoals() -> [Goal]? {
        allGoals = dataService.fetchGoals()
        return allGoals
    }
    
    func fillChartData() -> [DataPoint]? {
        if let unwrappedGoals = allGoals ?? nil {
            for goal in unwrappedGoals {
                let value = 1.0
                let label = LocalizedStringKey(String(calendar.component(.day, from: goal.createdAt)))
                let legend = noGoal
                chartGoalsData.append(DataPoint(value: value, label: label, legend: legend))
            }
        }
        return chartGoalsData
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

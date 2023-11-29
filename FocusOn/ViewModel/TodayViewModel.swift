//
//  TodayView-ViewModel.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 25/03/2022.
//

import Foundation
import Combine

class TodayViewModel: ObservableObject {
    @Published var todayGoal = Goal()
    @Published var allGoals: [Goal]?
    private let dataService: DataServiceProtocol
    
    init( dataService: DataServiceProtocol = DataService()) {
        self.dataService = dataService
        self.allGoals = dataService.allGoals
    }
    
    func fetchGoals() -> [Goal]? {
        allGoals = dataService.fetchGoals()
        return allGoals
    }
    
    func addGoal(name: String) throws {
        try dataService.upsertGoal(goal: todayGoal, name: name)
        todayGoal = allGoals?.last ?? Goal()
    }
    
    func updateGoal(goal: Goal, name: String) throws {
        try dataService.upsertGoal(goal: goal, name: name)
    }
    
    func updateTask(task: Task, name: String, isCompleted: Bool = false) throws {
        task.name = name
        task.isCompleted = isCompleted
        try dataService.updateTask(task: task, name: name, isCompleted: isCompleted)
    }
    
    func checkGoalIsCompleted(goal: Goal) {
        if (goal.isCompleted) {
            goal.tasks.forEach { task in
                task.isCompleted = false
            }
        } else {
            goal.tasks.forEach { task in
                task.isCompleted = true
            }
        }
    }
    
    func checkTaskIsCompleted(goal: Goal, task: Task) {
        task.isCompleted = !task.isCompleted
    }
}

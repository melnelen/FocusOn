//
//  TodayView-ViewModel.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 25/03/2022.
//

import Foundation
import Combine

class TodayViewModel: ObservableObject {
    // MARK: Published Properties
    @Published var goalText = ""
    @Published var tasksText = ["", "", ""]
    @Published var goalIsCompleted = false
    @Published var tasksAreCompleted = [false, false, false]
    @Published var allGoals: [Goal]?
    
    // MARK: Private Properties
    private let dataService: DataServiceProtocol
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
    
    // MARK: Public Properties
    func addNewGoal(name: String) throws {
        allGoals?.append(Goal(name: name))
        goalText = allGoals!.last!.name
        if let lastGoal = allGoals?.last {
            do {
                try dataService.upsertGoal(goal: lastGoal)
                allGoals = dataService.allGoals
            } catch {
                print("Error adding new goal: \(error)")
            }
        } else {
            print("No goals found")
        }
    }
    
    func updateGoal(goal: Goal, name: String, date: Date) throws {
        goal.name = name
        goalText = goal.name // ??
        goal.createdAt = Date()
        goalIsCompleted = goal.tasks.allSatisfy { $0.isCompleted }
        do {
            try dataService.upsertGoal(goal: goal)
            allGoals = dataService.allGoals
        } catch {
            print("Error updating goal: \(error)")
        }
        
    }
    
    func updateTask(goal: Goal, task: Task, name: String, isCompleted: Bool) throws {
        task.name = name
        task.isCompleted = isCompleted
        for (index, task) in goal.tasks.enumerated() {
            tasksText[index] = task.name
        }
        for (index, task) in goal.tasks.enumerated() {
            tasksAreCompleted[index] = task.isCompleted
        }
        do {
            try dataService.updateTask(goal: goal, task: task)
            allGoals = dataService.allGoals
        } catch {
            print("Error updating task: \(error)")
        }
    }
    
    func checkGoalIsCompleted(goal: Goal) throws {
        for (index, task) in goal.tasks.enumerated() {
            try updateTask(goal: goal, task: task, name: tasksText[index], isCompleted: !goalIsCompleted)
            tasksAreCompleted[index] = task.isCompleted
        }
        goalIsCompleted = goal.tasks.allSatisfy { $0.isCompleted }
        try updateGoal(goal: goal, name: goalText, date: goal.createdAt)
        allGoals = dataService.allGoals
    }
    
    func checkTaskIsCompleted(goal: Goal, task: Task) throws {
        // get the index of the task at hand
        guard let index = Array(goal.tasks).firstIndex(of: task) else {
            // Handle the case where the task is not found
            print("Task was not found!")
            return
        }
        
        do {
            if task.isCompleted {
                try updateTask(goal: goal, task: task, name: tasksText[index], isCompleted: false)
            } else {
                try updateTask(goal: goal, task: task, name: tasksText[index], isCompleted: true)
            }
            
            // Update tasksText only if the update was successful
            if let updatedTask = goal.tasks.first(where: { $0.id == task.id }) {
                tasksText[index] = updatedTask.name
            } else {
                // Handle the case where the task was not found after the update
                print("Task was not found after the update!")
            }
        } catch {
            // Handle the error from updateTask
            print("Error updating task: \(error)")
        }
        
        tasksAreCompleted[index] = task.isCompleted
        goalIsCompleted = goal.tasks.allSatisfy { $0.isCompleted }
        
        do {
            try updateGoal(goal: goal, name: goalText, date: goal.createdAt)
            allGoals = dataService.allGoals
        } catch {
            // Handle the error from updateGoal
            print("Error updating goal: \(error)")
        }
    }
    
    func formattedGoalDate(from date: Date) -> String {
        return goalDateFormatter.string(from: date)
    }
    
}

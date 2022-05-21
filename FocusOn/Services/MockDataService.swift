//
//  MockDataService.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 14/04/2022.
//

import Foundation

class MockDataService: DataServiceProtocol {
    private var savedGoals = [Goal]()
//    var savedGoals: [Goal] = [Goal(name: "test", isCompleted: false, tasks: [Task(), Task(), Task()])]

    func upsertGoals(goal: Goal, name: String, isCompleted: Bool) { }

    func fetchGoals() -> [Goal] {
        return savedGoals
    }

    func insertGoal(goal: Goal) {
        savedGoals.append(goal)
    }

    func updateGoal(goal: Goal, name: String, isCompleted: Bool) {
        goal.name = name
        goal.isCompleted = isCompleted
    }

    func updateTask(task: Task, name: String, isCompleted: Bool) {
        task.name = name
        task.isCompleted = isCompleted
    }
}

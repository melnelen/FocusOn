//
//  DataServiceProtocol.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 14/04/2022.
//

import Foundation

protocol DataServiceProtocol {
    func upsertGoals(goal: Goal, name: String, isCompleted: Bool)
    func fetchGoals() -> [Goal]
    func insertGoal(goal: Goal)
    func updateGoal(goal: Goal, name: String, isCompleted: Bool)
    func updateTask(task: Task, name: String, isCompleted: Bool)
}

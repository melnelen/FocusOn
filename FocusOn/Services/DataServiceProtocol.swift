//
//  DataServiceProtocol.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 14/04/2022.
//

import Foundation

protocol DataServiceProtocol {
    var allGoals: [Goal]? { get }
    func fetchGoals() -> [Goal]
    func upsertGoal(goal: Goal, name: String) throws
    func updateTask(task: Task, name: String, isCompleted: Bool) throws
}

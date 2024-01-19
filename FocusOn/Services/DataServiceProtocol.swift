//
//  DataServiceProtocol.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 14/04/2022.
//

import Foundation

protocol DataServiceProtocol {
    var allGoals: [Goal]? { get }
    func fetchGoals() 
    func upsertGoal(goal: Goal) throws
    func updateTask(goal: Goal, task: Task, name: String, isCompleted: Bool, index: Int) throws
    func deleteGoal(goal: Goal) throws
}

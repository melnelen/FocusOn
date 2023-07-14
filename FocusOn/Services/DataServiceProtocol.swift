//
//  DataServiceProtocol.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 14/04/2022.
//

import Foundation
import SwiftUICharts

protocol DataServiceProtocol {
    var allGoals: [Goal]? { get }
    var chartData: [DataPoint]? { get }
    func upsertGoals(goal: Goal, name: String, isCompleted: Bool)
    func fetchGoals() -> [Goal]
    func insertGoal(goal: Goal) throws
    func updateGoal(goal: Goal, name: String, isCompleted: Bool) throws
    func updateTask(task: Task, name: String, isCompleted: Bool) throws
}

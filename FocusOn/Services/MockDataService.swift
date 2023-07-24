//
//  MockDataService.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 14/04/2022.
//

import Foundation
import SwiftUICharts

class MockDataService: DataServiceProtocol {
    @Published var allGoals: [Goal]? = [Goal(name: "Test goal 1",
                                             createdAt: Calendar.current.date(byAdding: .day, value: -5, to: Date())!,
                                              isCompleted: false,
                                             tasks: [Task(name: "Test task 1.1", isCompleted: false),
                                                     Task(name: "Test task 1.2", isCompleted: false),
                                                     Task(name: "Test task 1.3", isCompleted: false)]),
                                        Goal(name: "Test goal 2",
                                             createdAt: Calendar.current.date(byAdding: .day, value: -4, to: Date())!,
                                             isCompleted: false,
                                             tasks: [Task(name: "Test task 2.1", isCompleted: true),
                                                     Task(name: "Test task 2.2", isCompleted: true),
                                                     Task(name: "Test task 2.3", isCompleted: false)]),
                                        Goal(name: "Test goal 3",
                                             createdAt: Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
                                             isCompleted: true,
                                             tasks: [Task(name: "Test task 3.1", isCompleted: true),
                                                     Task(name: "Test task 3.2", isCompleted: true),
                                                     Task(name: "Test task 3.3", isCompleted: true)]),
                                        Goal(name: "Test goal 4",
                                             createdAt: Calendar.current.date(byAdding: .day, value: -2, to: Date())!,
                                             isCompleted: false,
                                             tasks: [Task(name: "Test task 4.1", isCompleted: true),
                                                     Task(name: "Test task 4.2", isCompleted: false),
                                                     Task(name: "Test task 4.3", isCompleted: true)]),
                                        Goal(name: "Test goal 5",
                                             createdAt: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
                                             isCompleted: true,
                                             tasks: [Task(name: "Test task 5.1", isCompleted: true),
                                                     Task(name: "Test task 5.2", isCompleted: true),
                                                     Task(name: "Test task 5.3", isCompleted: true)])]
    
    @Published var chartData: [DataPoint]? = [DataPoint(value: 1, label: "1", legend: Legend(color: .red, label: "Fail", order: 2)),
                                        DataPoint(value: 2, label: "2", legend: Legend(color: .orange, label: "Small Progress", order: 3)),
                                        DataPoint(value: 3, label: "3", legend: Legend(color: .yellow, label: "Big Progress", order: 4)),
                                        DataPoint(value: 4, label: "4", legend: Legend(color: .green, label: "Success", order: 5)),
                                        DataPoint(value: 4, label: "5", legend: Legend(color: .green, label: "Success", order: 5)),
                                        DataPoint(value: 0, label: "6", legend: Legend(color: .gray, label: "No goal", order: 1)),
                                        DataPoint(value: 3, label: "7", legend: Legend(color: .yellow, label: "Big Progress", order: 4)),
                                        DataPoint(value: 3, label: "8", legend: Legend(color: .yellow, label: "Big Progress", order: 4)),
                                        DataPoint(value: 1, label: "9", legend: Legend(color: .red, label: "Fail", order: 2)),
                                        DataPoint(value: 4, label: "10", legend: Legend(color: .green, label: "Success", order: 5)),
                                        DataPoint(value: 4, label: "11", legend: Legend(color: .green, label: "Success", order: 5)),
                                        DataPoint(value: 3, label: "12", legend: Legend(color: .yellow, label: "Big Progress", order: 4)),
                                        DataPoint(value: 2, label: "13", legend: Legend(color: .orange, label: "Small Progress", order: 3)),
                                        DataPoint(value: 4, label: "14", legend: Legend(color: .green, label: "Success", order: 5))]

    func upsertGoals(goal: Goal, name: String, isCompleted: Bool) { }

    func fetchGoals() -> [Goal] {
        return allGoals ?? []
    }

    func insertGoal(goal: Goal) throws {
        try checkLength(of: goal.name)
        allGoals = allGoals ?? []
        allGoals?.append(goal)
    }

    func updateGoal(goal: Goal, name: String, isCompleted: Bool) throws {
        try checkLength(of: goal.name)
        goal.name = name
        goal.isCompleted = isCompleted
    }

    func updateTask(task: Task, name: String, isCompleted: Bool) throws {
        try checkLength(of: task.name)
        task.name = name
        task.isCompleted = isCompleted
    }

    func checkLength(of text: String) throws {
        // check that the text is at least 3 characters long
        guard text.count > 0 else { throw NameLengthError.empty }
        guard text.count >= 3 else { throw NameLengthError.short }
    }
}

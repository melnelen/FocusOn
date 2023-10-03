//
//  MockDataService.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 14/04/2022.
//

import Foundation
import SwiftUICharts

class MockDataService: DataServiceProtocol {
    @Published var allGoals: [Goal]? = [Goal(name: "Test goal 20",
                                             createdAt: Calendar.current.date(byAdding: .day, value: -20, to: Date())!,
                                             isCompleted: true,
                                             tasks: [Task(name: "Test task 20.1", isCompleted: true),
                                                     Task(name: "Test task 20.2", isCompleted: true),
                                                     Task(name: "Test task 20.3", isCompleted: true)]),
                                        Goal(name: "Test goal 19",
                                             createdAt: Calendar.current.date(byAdding: .day, value: -19, to: Date())!,
                                             isCompleted: true,
                                             tasks: [Task(name: "Test task 19.1", isCompleted: true),
                                                     Task(name: "Test task 19.2", isCompleted: true),
                                                     Task(name: "Test task 19.3", isCompleted: true)]),
                                        Goal(name: "Test goal 18",
                                             createdAt: Calendar.current.date(byAdding: .day, value: -18, to: Date())!,
                                             isCompleted: false,
                                             tasks: [Task(name: "Test task 18.1", isCompleted: true),
                                                     Task(name: "Test task 18.2", isCompleted: false),
                                                     Task(name: "Test task 18.3", isCompleted: false)]),
                                        Goal(name: "Test goal 17",
                                             createdAt: Calendar.current.date(byAdding: .day, value: -17, to: Date())!,
                                             isCompleted: true,
                                             tasks: [Task(name: "Test task 17.1", isCompleted: true),
                                                     Task(name: "Test task 17.2", isCompleted: true),
                                                     Task(name: "Test task 17.3", isCompleted: true)]),
                                        Goal(name: "Test goal 16",
                                             createdAt: Calendar.current.date(byAdding: .day, value: -16, to: Date())!,
                                             isCompleted: false,
                                             tasks: [Task(name: "Test task 16.1", isCompleted: true),
                                                     Task(name: "Test task 16.2", isCompleted: false),
                                                     Task(name: "Test task 16.3", isCompleted: true)]),
                                        Goal(name: "Test goal 15",
                                             createdAt: Calendar.current.date(byAdding: .day, value: -15, to: Date())!,
                                             isCompleted: true,
                                             tasks: [Task(name: "Test task 15.1", isCompleted: true),
                                                     Task(name: "Test task 15.2", isCompleted: true),
                                                     Task(name: "Test task 15.3", isCompleted: true)]),
                                        Goal(name: "Test goal 14",
                                             createdAt: Calendar.current.date(byAdding: .day, value: -14, to: Date())!,
                                             isCompleted: true,
                                             tasks: [Task(name: "Test task 14.1", isCompleted: true),
                                                     Task(name: "Test task 14.2", isCompleted: true),
                                                     Task(name: "Test task 14.3", isCompleted: true)]),
                                        Goal(name: "Test goal 13",
                                             createdAt: Calendar.current.date(byAdding: .day, value: -13, to: Date())!,
                                             isCompleted: true,
                                             tasks: [Task(name: "Test task 13.1", isCompleted: true),
                                                     Task(name: "Test task 13.2", isCompleted: true),
                                                     Task(name: "Test task 13.3", isCompleted: true)]),
                                        Goal(name: "Test goal 12",
                                             createdAt: Calendar.current.date(byAdding: .day, value: -12, to: Date())!,
                                             isCompleted: false,
                                             tasks: [Task(name: "Test task 12.1", isCompleted: false),
                                                     Task(name: "Test task 12.2", isCompleted: false),
                                                     Task(name: "Test task 12.3", isCompleted: false)]),
                                        Goal(name: "Test goal 11",
                                             createdAt: Calendar.current.date(byAdding: .day, value: -11, to: Date())!,
                                             isCompleted: true,
                                             tasks: [Task(name: "Test task 11.1", isCompleted: true),
                                                     Task(name: "Test task 11.2", isCompleted: true),
                                                     Task(name: "Test task 11.3", isCompleted: true)]),
                                        Goal(name: "Test goal 10",
                                             createdAt: Calendar.current.date(byAdding: .day, value: -10, to: Date())!,
                                             isCompleted: false,
                                             tasks: [Task(name: "Test task 10.1", isCompleted: true),
                                                     Task(name: "Test task 10.2", isCompleted: true),
                                                     Task(name: "Test task 10.3", isCompleted: false)]),
                                        Goal(name: "Test goal 9",
                                             createdAt: Calendar.current.date(byAdding: .day, value: -9, to: Date())!,
                                             isCompleted: true,
                                             tasks: [Task(name: "Test task 9.1", isCompleted: true),
                                                     Task(name: "Test task 9.2", isCompleted: true),
                                                     Task(name: "Test task 9.3", isCompleted: true)]),
                                        Goal(name: "Test goal 8",
                                             createdAt: Calendar.current.date(byAdding: .day, value: -8, to: Date())!,
                                             isCompleted: true,
                                             tasks: [Task(name: "Test task 8.1", isCompleted: true),
                                                     Task(name: "Test task 8.2", isCompleted: true),
                                                     Task(name: "Test task 8.3", isCompleted: true)]),
                                        Goal(name: "Test goal 6",
                                             createdAt: Calendar.current.date(byAdding: .day, value: -6, to: Date())!,
                                             isCompleted: true,
                                             tasks: [Task(name: "Test task 6.1", isCompleted: true),
                                                     Task(name: "Test task 6.2", isCompleted: false),
                                                     Task(name: "Test task 6.3", isCompleted: false)]),
                                        Goal(name: "Test goal 5",
                                             createdAt: Calendar.current.date(byAdding: .day, value: -5, to: Date())!,
                                             isCompleted: false,
                                             tasks: [Task(name: "Test task 5.1", isCompleted: true),
                                                     Task(name: "Test task 5.2", isCompleted: true),
                                                     Task(name: "Test task 5.3", isCompleted: false)]),
                                        Goal(name: "Test goal 4",
                                             createdAt: Calendar.current.date(byAdding: .day, value: -4, to: Date())!,
                                             isCompleted: false,
                                             tasks: [Task(name: "Test task 4.1", isCompleted: false),
                                                     Task(name: "Test task 4.2", isCompleted: false),
                                                     Task(name: "Test task 4.3", isCompleted: false)]),
                                        Goal(name: "Test goal 3",
                                             createdAt: Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
                                             isCompleted: true,
                                             tasks: [Task(name: "Test task 3.1", isCompleted: true),
                                                     Task(name: "Test task 3.2", isCompleted: true),
                                                     Task(name: "Test task 3.3", isCompleted: true)]),
                                        Goal(name: "Test goal 2",
                                             createdAt: Calendar.current.date(byAdding: .day, value: -2, to: Date())!,
                                             isCompleted: false,
                                             tasks: [Task(name: "Test task 2.1", isCompleted: true),
                                                     Task(name: "Test task 2.2", isCompleted: false),
                                                     Task(name: "Test task 2.3", isCompleted: true)]),
                                        Goal(name: "Test goal 1",
                                             createdAt: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
                                             isCompleted: true,
                                             tasks: [Task(name: "Test task 1.1", isCompleted: true),
                                                     Task(name: "Test task 1.2", isCompleted: true),
                                                     Task(name: "Test task 1.3", isCompleted: true)])]
    
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

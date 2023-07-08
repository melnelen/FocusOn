//
//  MockDataService.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 14/04/2022.
//

import Foundation

class MockDataService: DataServiceProtocol {
    //    @Published var allGoals: [Goal]?
    @Published var allGoals: [Goal]? = [Goal(name: "Test goal 1", isCompleted: false,
                                             tasks: [Task(name: "Test task 1.1", isCompleted: false),
                                                     Task(name: "Test task 1.2", isCompleted: false),
                                                     Task(name: "Test task 1.3", isCompleted: false)]),
                                        Goal(name: "Test goal 2", isCompleted: false,
                                             tasks: [Task(name: "Test task 2.1", isCompleted: true),
                                                     Task(name: "Test task 2.2", isCompleted: true),
                                                     Task(name: "Test task 2.3", isCompleted: false)]),
                                        Goal(name: "Test goal 3", isCompleted: true,
                                             tasks: [Task(name: "Test task 3.1", isCompleted: true),
                                                     Task(name: "Test task 3.2", isCompleted: true),
                                                     Task(name: "Test task 3.3", isCompleted: true)]),
                                        Goal(name: "Test goal 4", isCompleted: false,
                                             tasks: [Task(name: "Test task 4.1", isCompleted: true),
                                                     Task(name: "Test task 4.2", isCompleted: false),
                                                     Task(name: "Test task 4.3", isCompleted: true)]),
                                        Goal(name: "Test goal 5", isCompleted: true,
                                             tasks: [Task(name: "Test task 5.1", isCompleted: true),
                                                     Task(name: "Test task 5.2", isCompleted: true),
                                                     Task(name: "Test task 5.3", isCompleted: true)])]

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

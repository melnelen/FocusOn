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

    func insertGoal(goal: Goal) throws {
        try checkLength(of: goal.name)
        savedGoals.append(goal)
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

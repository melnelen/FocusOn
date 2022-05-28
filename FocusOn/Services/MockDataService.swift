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
        // check that the name of the goal is at least 3 characters long
        guard goal.name.count > 0 else { throw NameLengthError.empty }
        guard goal.name.count >= 3 else { throw NameLengthError.short }

        savedGoals.append(goal)
    }

    func updateGoal(goal: Goal, name: String, isCompleted: Bool) throws {
        // check that the name of the goal is at least 3 characters long
        guard goal.name.count > 0 else { throw NameLengthError.empty }
        guard goal.name.count >= 3 else { throw NameLengthError.short }

        goal.name = name
        goal.isCompleted = isCompleted
    }

    func updateTask(task: Task, name: String, isCompleted: Bool) throws {
        // check that the name of the task is at least 3 characters long
        guard task.name.count > 0 else { throw NameLengthError.empty }
        guard task.name.count >= 3 else { throw NameLengthError.short }

        task.name = name
        task.isCompleted = isCompleted
    }
}

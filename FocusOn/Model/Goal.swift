//
//  Goal.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 06/04/2022.
//

import Foundation

struct Goal: Identifiable {
    let id: UUID
    let name: String
    let createdAt: Date
    let isCompleted: Bool
    let tasks: Set<Task>?

//    init(id: UUID, name: String, createdAt: Date, isCompleted: Bool, tasks: Set<Task>) {
//        self.id = id
//        self.name = name
//        self.createdAt = createdAt
//        self.isCompleted = isCompleted
//        self.tasks = tasks
//    }

    func updateGoal(id: UUID, name: String, createdAt: Date, isCompleted: Bool, tasks: Set<Task>) -> Goal {
        return Goal(id: id , name: name, createdAt: createdAt, isCompleted: isCompleted, tasks: tasks)
    }

    func updateName(name: String) -> Goal {
        return Goal(id: id, name: name, createdAt: createdAt, isCompleted: isCompleted, tasks: tasks)
    }

    func updateCompletionStatus(status: Bool) -> Goal {
        return Goal(id: id, name: name, createdAt: createdAt, isCompleted: status, tasks: tasks)
    }
}

//
//  Goal.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 06/04/2022.
//

import Foundation

class Goal: Identifiable, Hashable, ObservableObject {
    static func == (lhs: Goal, rhs: Goal) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: UUID 
    var name: String
    let createdAt: Date
    var isCompleted: Bool {
        return tasks.allSatisfy { $0.isCompleted }
    }
    var tasks: [Task]

    init() {
        self.id = UUID()
        self.name = ""
        self.createdAt = Date()
//        self.isCompleted = false
        self.tasks = [Task(), Task(), Task()]
    }

    init(name: String, createdAt: Date, tasks: Array<Task>) {
        self.id = UUID()
        self.name = name
        self.createdAt = createdAt
//        self.isCompleted = isCompleted
        self.tasks = tasks
    }
}

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
    @Published var name: String
    @Published var createdAt: Date
    var isCompleted: Bool {
        return tasks.allSatisfy { $0.isCompleted }
    }
    @Published var tasks: [Task]

    init() {
        self.id = UUID()
        self.name = ""
        self.createdAt = Date()
        self.tasks = [Task(), Task(), Task()]
    }
    
    init(name: String) {
        self.id = UUID()
        self.name = name
        self.createdAt = Date()
        self.tasks = [Task(), Task(), Task()]
    }

    init(name: String, createdAt: Date, tasks: Array<Task>) {
        self.id = UUID()
        self.name = name
        self.createdAt = createdAt
        self.tasks = tasks
    }
    
    init(id: UUID, name: String, createdAt: Date, tasks: Array<Task>) {
        self.id = id
        self.name = name
        self.createdAt = createdAt
        self.tasks = tasks
    }
}

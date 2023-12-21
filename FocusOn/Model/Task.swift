//
//  Task.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 06/04/2022.
//

import Foundation

class Task: Identifiable, Hashable, Equatable, ObservableObject {
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    let id: UUID
    @Published var name: String
    @Published var isCompleted: Bool

    init() {
        self.id = UUID()
        self.name = ""
        self.isCompleted = false
    }

    init(name: String, isCompleted: Bool) {
        self.id = UUID()
        self.name = name
        self.isCompleted = isCompleted
    }
    init(id: UUID, name: String, isCompleted: Bool) {
        self.id = UUID()
        self.name = name
        self.isCompleted = isCompleted
    }
}

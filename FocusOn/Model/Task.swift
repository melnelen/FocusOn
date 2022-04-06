//
//  Task.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 06/04/2022.
//

import Foundation

struct Task: Identifiable, Hashable {
    let id: UUID
    let name: String
    let isCompleted: Bool

//    init(id: UUID, name: String, isCompleted: Bool) {
//        self.id = id
//        self.name = name
//        self.isCompleted = isCompleted
//    }

    func changeCompletionStatus() -> Task {
        return Task(id: id, name: name, isCompleted: !isCompleted)
    }

    func updateCompletionStatus(status: Bool) -> Task {
        return Task(id: id, name: name, isCompleted: status)
    }
}

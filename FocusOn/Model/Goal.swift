//
//  Goal.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 06/04/2022.
//

import Foundation

class Goal: Identifiable, ObservableObject {
    let id: UUID 
    var name: String
    let createdAt: Date
    var isCompleted: Bool
    var tasks: Set<Task>

    init() {
        self.id = UUID()
        self.name = ""
        self.createdAt = Date()
        self.isCompleted = false
        self.tasks = [Task(), Task(), Task()]
    }
}

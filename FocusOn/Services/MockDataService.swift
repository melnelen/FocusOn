//
//  MockDataService.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 14/04/2022.
//

import Foundation
import SwiftUICharts

class MockDataService: DataServiceProtocol {
    @Published var allGoals: [Goal]? = [Goal(name: "Test goal 23",
                                             createdAt: Date(timeIntervalSince1970: 1695204000), // Wed 20 Sep 2023
                                             tasks: [Task(name: "Test task 23.1", isCompleted: true),
                                                     Task(name: "Test task 23.2", isCompleted: true),
                                                     Task(name: "Test task 23.3", isCompleted: true)]),
                                        Goal(name: "Test goal 22",
                                             createdAt: Date(timeIntervalSince1970: 1695290400), // Thu 21 Sep 2023
                                             tasks: [Task(name: "Test task 22.1", isCompleted: true),
                                                     Task(name: "Test task 22.2", isCompleted: true),
                                                     Task(name: "Test task 22.3", isCompleted: true)]),
                                        Goal(name: "Test goal 21",
                                             createdAt: Date(timeIntervalSince1970: 1695376800), // Fri 22 Sep 2023
                                             tasks: [Task(name: "Test task 21.1", isCompleted: true),
                                                     Task(name: "Test task 21.2", isCompleted: true),
                                                     Task(name: "Test task 21.3", isCompleted: true)]),
                                        Goal(name: "Test goal 20",
                                             createdAt: Date(timeIntervalSince1970: 1695463200), // Sat 23 Sep 2023
                                             tasks: [Task(name: "Test task 20.1", isCompleted: true),
                                                     Task(name: "Test task 20.2", isCompleted: true),
                                                     Task(name: "Test task 20.3", isCompleted: true)]),
                                        Goal(name: "Test goal 19",
                                             createdAt: Date(timeIntervalSince1970: 1695549600), // Sun 24 Sep 2023
                                             tasks: [Task(name: "Test task 19.1", isCompleted: true),
                                                     Task(name: "Test task 19.2", isCompleted: true),
                                                     Task(name: "Test task 19.3", isCompleted: true)]),
                                        Goal(name: "Test goal 18",
                                             createdAt: Date(timeIntervalSince1970: 1695636000), // Mon 25 Sep 2023
                                             tasks: [Task(name: "Test task 18.1", isCompleted: true),
                                                     Task(name: "Test task 18.2", isCompleted: true),
                                                     Task(name: "Test task 18.3", isCompleted: true)]),
                                        Goal(name: "Test goal 17",
                                             createdAt: Date(timeIntervalSince1970: 1695722400), // Tue 26 Sep 2023
                                             tasks: [Task(name: "Test task 17.1", isCompleted: true),
                                                     Task(name: "Test task 17.2", isCompleted: true),
                                                     Task(name: "Test task 17.3", isCompleted: true)]),
                                        Goal(name: "Test goal 16",
                                             createdAt: Date(timeIntervalSince1970: 1695808800), // Wed 27 Sep 2023
                                             tasks: [Task(name: "Test task 16.1", isCompleted: true),
                                                     Task(name: "Test task 16.2", isCompleted: false),
                                                     Task(name: "Test task 16.3", isCompleted: true)]),
                                        Goal(name: "Test goal 14",
                                             createdAt: Date(timeIntervalSince1970: 1695981600), // Fri 29 Sep 2023
                                             tasks: [Task(name: "Test task 14.1", isCompleted: true),
                                                     Task(name: "Test task 14.2", isCompleted: true),
                                                     Task(name: "Test task 14.3", isCompleted: true)]),
                                        Goal(name: "Test goal 13",
                                             createdAt: Date(timeIntervalSince1970: 1696068000), // Sat 30 Sep 2023
                                             tasks: [Task(name: "Test task 13.1", isCompleted: true),
                                                     Task(name: "Test task 13.2", isCompleted: true),
                                                     Task(name: "Test task 13.3", isCompleted: true)]),
                                        Goal(name: "Test goal 12",
                                             createdAt: Date(timeIntervalSince1970: 1696154400), // Sun 01 Oct 2023
                                             tasks: [Task(name: "Test task 12.1", isCompleted: false),
                                                     Task(name: "Test task 12.2", isCompleted: false),
                                                     Task(name: "Test task 12.3", isCompleted: false)]),
                                        Goal(name: "Test goal 11",
                                             createdAt: Date(timeIntervalSince1970: 1696240800), // Mon 02 Oct 2023
                                             tasks: [Task(name: "Test task 11.1", isCompleted: true),
                                                     Task(name: "Test task 11.2", isCompleted: true),
                                                     Task(name: "Test task 11.3", isCompleted: true)]),
                                        Goal(name: "Test goal 10",
                                             createdAt: Date(timeIntervalSince1970: 1696327200), // Tue 03 Oct 2023
                                             tasks: [Task(name: "Test task 10.1", isCompleted: true),
                                                     Task(name: "Test task 10.2", isCompleted: true),
                                                     Task(name: "Test task 10.3", isCompleted: false)]),
                                        Goal(name: "Test goal 9",
                                             createdAt: Date(timeIntervalSince1970: 1696413600), // Wed 04 Oct 2023
                                             tasks: [Task(name: "Test task 9.1", isCompleted: true),
                                                     Task(name: "Test task 9.2", isCompleted: true),
                                                     Task(name: "Test task 9.3", isCompleted: true)]),
                                        Goal(name: "Test goal 8",
                                             createdAt: Date(timeIntervalSince1970: 1696500000), // Thu 05 Oct 2023
                                             tasks: [Task(name: "Test task 8.1", isCompleted: true),
                                                     Task(name: "Test task 8.2", isCompleted: true),
                                                     Task(name: "Test task 8.3", isCompleted: true)]),
                                        Goal(name: "Test goal 6",
                                             createdAt: Date(timeIntervalSince1970: 1696672800), // Sat 07 Oct 2023
                                             tasks: [Task(name: "Test task 6.1", isCompleted: true),
                                                     Task(name: "Test task 6.2", isCompleted: false),
                                                     Task(name: "Test task 6.3", isCompleted: false)]),
                                        Goal(name: "Test goal 5",
                                             createdAt: Date(timeIntervalSince1970: 1696759200), // Sun 08 Oct 2023
                                             tasks: [Task(name: "Test task 5.1", isCompleted: true),
                                                     Task(name: "Test task 5.2", isCompleted: true),
                                                     Task(name: "Test task 5.3", isCompleted: false)]),
                                        Goal(name: "Test goal 4",
                                             createdAt: Date(timeIntervalSince1970: 1696845600), // Mon 09 Oct 2023
                                             tasks: [Task(name: "Test task 4.1", isCompleted: false),
                                                     Task(name: "Test task 4.2", isCompleted: false),
                                                     Task(name: "Test task 4.3", isCompleted: false)]),
                                        Goal(name: "Test goal 3",
                                             createdAt: Date(timeIntervalSince1970: 1696932000), // Tue 10 Oct 2023
                                             tasks: [Task(name: "Test task 3.1", isCompleted: true),
                                                     Task(name: "Test task 3.2", isCompleted: false),
                                                     Task(name: "Test task 3.3", isCompleted: false)]),
                                        Goal(name: "Test goal 2",
                                             createdAt: Date(timeIntervalSince1970: 1697018400), // Wed 11 Oct 2023
                                             tasks: [Task(name: "Test task 2.1", isCompleted: true),
                                                     Task(name: "Test task 2.2", isCompleted: true),
                                                     Task(name: "Test task 2.3", isCompleted: false)]),
                                        Goal(name: "Test goal 0",
                                             createdAt: Date(timeIntervalSince1970: 1697191200), // Fri 13 Oct 2023
                                             tasks: [Task(name: "Test task 0.1", isCompleted: true),
                                                     Task(name: "Test task 0.2", isCompleted: true),
                                                     Task(name: "Test task 0.3", isCompleted: true)])]
    
    func fetchGoals() -> [Goal] {
        return allGoals ?? []
    }
    
    func upsertGoal(goal: Goal) throws {
        // check if gaol already exists
        if let updatedGoal = allGoals?.first(where: { $0.id == goal.id }) {
            // update goal
            updatedGoal.name = goal.name
        // if not, create new goal
        } else {
            allGoals = allGoals ?? []
            allGoals?.append(goal)
        }
    }
    
    func updateTask(task: Task) throws {
        // check if task already exists
        let allTasks = extractTasks(from: allGoals ?? [])
        if let updatedTask = allTasks.first(where: { $0.id == task.id }) {
            // update task
            updatedTask.name = task.name
            updatedTask.isCompleted = task.isCompleted
        }
    }
    
    func extractTasks(from goals: [Goal]) -> [Task] {
        return goals.flatMap { $0.tasks }
    }
    
//    func checkLength(of text: String) throws {
//        // check that the text is at least 3 characters long
//        guard text.count > 0 else { throw NameLengthError.empty }
//        guard text.count >= 3 else { throw NameLengthError.short }
//    }
}

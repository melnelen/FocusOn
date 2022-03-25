//
//  TodayView-ViewModel.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 25/03/2022.
//

import Foundation
import CoreData

class TodayViewModel: ObservableObject {

    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "FocusOn")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            } else {
                print("Successfully loaded core data!")
            }
        })
    }

    @Published var goal = Goal()

    func checkGoalCompletionStatus() {
        if (goal.completionStatus) {
            goal.completionStatus = false
            goal.tasks[0].completionStatus = false
            goal.tasks[1].completionStatus = false
            goal.tasks[2].completionStatus = false

            if !(goal.tasks[0].completionStatus &&
                 goal.tasks[1].completionStatus &&
                 goal.tasks[2].completionStatus) {
                goal.completionStatus = false
            }
        } else {
            goal.completionStatus = true
            goal.tasks[0].completionStatus = true
            goal.tasks[1].completionStatus = true
            goal.tasks[2].completionStatus = true
        }
    }

    func checkAllTasksCompletionStatus() {
        goal.completionStatus = (goal.tasks[0].completionStatus &&
                                 goal.tasks[1].completionStatus &&
                                 goal.tasks[2].completionStatus)
    }
}


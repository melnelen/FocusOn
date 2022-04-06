//
//  TodayView-ViewModel.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 25/03/2022.
//

import Foundation
import CoreData

class TodayViewModel: ObservableObject {

    let dataManager = PersistenceController.shared
    
    func checkGoalCompletionStatus(entity: Goal) {
        if (entity.completionStatus) {
            dataManager.updateGoalCompletionStatus(entity: entity, completionStatus: false)
            entity.tasks?.forEach { task in
                dataManager.updateTaskCompletionStatus(entity: task as! Task, completionStatus: false)
            }
            if ((entity.tasks?.contains(false))!) {
                dataManager.updateGoalCompletionStatus(entity: entity, completionStatus: false)
            }
        } else {
            dataManager.updateGoalCompletionStatus(entity: entity, completionStatus: true)
            entity.tasks?.forEach { task in
                dataManager.updateTaskCompletionStatus(entity: task as! Task, completionStatus: true)
            }
        }
    }

    func checkAllTasksCompletionStatus(entity: Goal) {
        if !((entity.tasks?.contains(false))!) {
            dataManager.updateGoalCompletionStatus(entity: entity, completionStatus: true)
        }
    }
}


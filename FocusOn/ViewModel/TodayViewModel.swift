//
//  TodayView-ViewModel.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 25/03/2022.
//

import Foundation
import CoreData

class TodayViewModel: ObservableObject {

    let goalDataService = GoalDataService.shared

    @Published var goals: [Goal] = []

    func checkGoal(goal: Goal) -> Goal {
        var updatedGoal = Goal(
            id: goal.id,
            name: goal.name,
            createdAt: goal.createdAt,
            isCompleted: goal.isCompleted,
            tasks: goal.tasks)

        if (goal.isCompleted) {
            updatedGoal = goal.updateCompletionStatus(status: false)
            goal.tasks?.forEach { task in
                var updatedTask = task.updateCompletionStatus(status: false)
            }
            goal.tasks?.forEach { task in
                if (!task.isCompleted) {
                    updatedGoal = goal.updateCompletionStatus(status: false)
                }
            }
        } else {
            updatedGoal = goal.updateCompletionStatus(status: true)
            goal.tasks?.forEach { task in
                var updatedTask = task.updateCompletionStatus(status: false)
            }
        }
        return updatedGoal
    }

    func checkTasks(goal: Goal) -> Goal {
        var updatedGoal = Goal(
            id: goal.id,
            name: goal.name,
            createdAt: goal.createdAt,
            isCompleted: true,
            tasks: goal.tasks)
        
        goal.tasks?.forEach { task in
            if (!task.isCompleted) {
                updatedGoal = goal.updateCompletionStatus(status: false)
            }
        }
        return updatedGoal
    }
//
//    func checkGoalCompletionStatus(entity: Goal) {
//        if (entity.isCompleted) {
//            goalDataService.updateGoalCompletionStatus(entity: entity, completionStatus: false)
//            entity.tasks?.forEach { task in
//                goalDataService.updateTaskCompletionStatus(entity: task as! Task, completionStatus: false)
//            }
//            if ((goal.tasks?.contains(false))!) {
//                goalDataService.updateGoalCompletionStatus(entity: goal, completionStatus: false)
//            }
//        } else {
//            dataManager.updateGoalCompletionStatus(entity: goal, completionStatus: true)
//            goal.tasks?.forEach { task in
//                goalDataService.updateTaskCompletionStatus(entity: task as! Task, completionStatus: true)
//            }
//        }
//    }
//
//    func checkAllTasksCompletionStatus(entity: Goal) {
//        if !((entity.tasks?.contains(false))!) {
//            goalDataService.updateGoalCompletionStatus(entity: entity, completionStatus: true)
//        }
//    }
}


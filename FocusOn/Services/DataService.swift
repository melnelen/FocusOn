//
//  GoalDataService.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 06/04/2022.
//

import Foundation
import CoreData

class DataService: DataServiceProtocol {
    @Published var allGoals: [Goal]?
    let container: NSPersistentContainer
    private let containerName: String = "FocusOn"
    private let goalEntityName: String = "GoalEntity"
    private let taskEntityName: String = "TaskEntity"
    private var savedGoalsEntities: [GoalEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Error loading Core Data! \(error)")
            } else {
                print("Successfully loaded core data!")
            }
        })
        allGoals = fetchGoals()
    }
    
    // MARK: PUBLIC
    
    func fetchGoals() -> [Goal] {
        let request = NSFetchRequest<GoalEntity>(entityName: goalEntityName)
        
        do {
            savedGoalsEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching! \(error)")
        }
        
        return savedGoalsEntities.map { convertToGoal(goalEntity: $0) }
    }
    
    func upsertGoal(goal: Goal, name: String) throws {
        // Check if goal already exists
        let request = NSFetchRequest<GoalEntity>(entityName: goalEntityName)
        request.predicate = NSPredicate(format: "id == %@", goal.id as CVarArg)
        
        do {
            try checkLength(of: name)
            let result = try container.viewContext.fetch(request)
            
            // Update existing goal
            if let updatedGoalEntity = result.first {
                updatedGoalEntity.name = name
                updatedGoalEntity.completionStatus = goal.isCompleted
                
                // Update existing tasks
                updateTasksForGoal(goal: goal)
            } else {
                
                // Create new goal
                let newGoalEntity = GoalEntity(context: container.viewContext)
                newGoalEntity.id = UUID()
                newGoalEntity.name = name
                newGoalEntity.createdAt = Date()
                newGoalEntity.completionStatus = goal.isCompleted
                
                // Add tasks to new goal
                addTasksToNewGoal(goalID: newGoalEntity.id!)
            }
            save()
            
        } catch {
            print("Error fetching or saving a goal: \(error)")
        }
    }
    
    func updateTask(task: Task, name: String, isCompleted: Bool = false) throws{
        //        try checkLength(of: task.name)
        
        let request = NSFetchRequest<TaskEntity>(entityName: taskEntityName)
        request.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
        
        do {
            let result = try container.viewContext.fetch(request)
            if let entity = result.first {
                try checkLength(of: name)
                entity.name = name
                entity.completionStatus = isCompleted
                save()
            }
        } catch let error {
            print("Error fetching or saving a task: \(error)")
        }
    }
    
    // MARK: PRIVATE
    
    private func addTasksToNewGoal(goalID: UUID) {
        guard let goalEntity = savedGoalsEntities.first(where: { $0.id == goalID }) else {
            print("Goal not found with ID: \(goalID)")
            return
        }
        
        for _ in 1...3 {
            let newTaskEntity = TaskEntity(context: container.viewContext)
            newTaskEntity.id = UUID()
            newTaskEntity.name = "My new task"
            newTaskEntity.completionStatus = false
            
            goalEntity.tasks?.adding(newTaskEntity)
        }
        save()
    }
    
    private func updateTasksForGoal(goal: Goal) {
        // Check if goal already exists
        let request = NSFetchRequest<GoalEntity>(entityName: goalEntityName)
        request.predicate = NSPredicate(format: "id == %@", goal.id as CVarArg)
        
        do {
            let result = try container.viewContext.fetch(request)
            
            if let updatedGoalEntity = result.first {
                for taskEntity in updatedGoalEntity.tasks?.allObjects as! [TaskEntity] {
                    for task in goal.tasks {
                        if taskEntity.id == task.id {
                            taskEntity.name = task.name
                            taskEntity.completionStatus = task.isCompleted
                        }
                    }
                }
            }
        } catch {
            print("Error fetching or saving a goal and it's tasks: \(error)")
        }
    }
    
    private func deleteGoal(goalID: UUID) {
        guard let goalEntity = savedGoalsEntities.first(where: { $0.id == goalID }) else {
            print("Goal not found with ID: \(goalID)")
            return
        }
        
        container.viewContext.delete(goalEntity)
        save()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
            allGoals = fetchGoals()
            print("Successfully saved to Core Data!")
        } catch let error {
            print("Error saving to Core Data. \(error)")
        }
    }
    
    private func convertToGoal(goalEntity: GoalEntity) -> Goal {
        let tasks = (goalEntity.tasks?.allObjects as? [TaskEntity])?.map { convertToTask(taskEntity: $0) } ?? []
        
        return Goal(id: goalEntity.id!,
                    name: goalEntity.name!,
                    createdAt: goalEntity.createdAt!,
                    tasks: tasks)
    }
    
    private func convertToTask(taskEntity: TaskEntity) -> Task {
        return Task(id: taskEntity.id!,
                    name: taskEntity.name!,
                    isCompleted: taskEntity.completionStatus)
    }
    
    
    func checkLength(of text: String) throws {
        // check that the text is at least 3 characters long
        guard text.count > 0 else { throw NameLengthError.empty }
        guard text.count >= 3 else { throw NameLengthError.short }
    }
    
}

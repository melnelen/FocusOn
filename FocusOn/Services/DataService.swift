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
    private let containerName: String = "FocusOnDataModel"
    private let goalEntityName: String = "GoalEntity"
    private let taskEntityName: String = "TaskEntity"
    private let goalTaskEntities: String = "taskEntities"
    private var savedGoalsEntities: [GoalEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Error loading Core Data! \(error)")
            } else {
                print("Successfully loaded core data!")
                self.fetchGoals()
            }
        })
    }
    
    // MARK: PUBLIC
    
    func fetchGoals() {
        let request = NSFetchRequest<GoalEntity>(entityName: goalEntityName)

        do {
            savedGoalsEntities = try container.viewContext.fetch(request)
            allGoals = savedGoalsEntities.map { convertToGoal(goalEntity: $0) }
            print("Goals loaded successfully!")
        } catch let error {
            print("Error fetching! \(error)")
        }
    }
    
    func upsertGoal(goal: Goal) throws {
        let request = NSFetchRequest<GoalEntity>(entityName: goalEntityName)
        request.predicate = NSPredicate(format: "id == %@", goal.id as CVarArg)
        
        do {
            let result = try container.viewContext.fetch(request)
            // Check if goal entity already exists
            if result.first != nil {
                update(goal: goal)
            } else {
                createNewGoalEntity(from: goal)
            }
            save()
            
        } catch {
            print("Error fetching or saving a goal: \(error)")
        }
    }
    
    func updateTask(goal: Goal, task: Task) throws {
        let request = NSFetchRequest<TaskEntity>(entityName: taskEntityName)
        request.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
        
        do {
            let result = try container.viewContext.fetch(request)
            if let entity = result.first {
                entity.name = task.name
                entity.isCompleted = task.isCompleted
            }
            update(goal: goal)
            save()
            
        } catch let error {
            print("Error fetching or saving a task: \(error)")
        }
    }
    
    // MARK: PRIVATE
    
    private func createNewGoalEntity(from goal: Goal) {
        // Create new goal entity
        let entity = GoalEntity(context: container.viewContext)
        entity.id = goal.id
        entity.name = goal.name
        entity.createdAt = goal.createdAt
        
        // Add tasks to new goal entity
        addTasksToNewGoal(goalEntity: entity, goalTasks: goal.tasks)
        save()
    }
    
    private func update(goal: Goal) {
        let request = NSFetchRequest<GoalEntity>(entityName: goalEntityName)
        request.predicate = NSPredicate(format: "id == %@", goal.id as CVarArg)
        
        do {
            let result = try container.viewContext.fetch(request)
            // Check if goal entity already exists
            if let entity = result.first {
                // Update the goal's name
                entity.name = goal.name
                entity.createdAt = goal.createdAt
            }
            
            // Update existing tasks
            updateTasksForGoal(goal: goal)
            
            // Save changes after all updates
            save()
            
        } catch {
            print("Error fetching or saving a goal: \(error)")
        }
    }
    
    private func addTasksToNewGoal(goalEntity: GoalEntity, goalTasks: [Task]) {
        for task in goalTasks {
            let newTaskEntity = TaskEntity(context: container.viewContext)
            newTaskEntity.id = task.id
            newTaskEntity.name = task.name
            newTaskEntity.isCompleted = task.isCompleted
            
            let mutableTaskSet = goalEntity.mutableSetValue(forKey: goalTaskEntities)
            mutableTaskSet.add(newTaskEntity)
        }
        save()
    }
    
    private func updateTasksForGoal(goal: Goal) {
        // Check if goal already exists
        let request = NSFetchRequest<GoalEntity>(entityName: goalEntityName)
        request.predicate = NSPredicate(format: "id == %@", goal.id as CVarArg)
        
        do {
            let result = try container.viewContext.fetch(request)
            guard let goalEntity = result.first else {
                print("Goal not found for ID: \(goal.id)")
                return
            }
            
            for taskEntity in goalEntity.taskEntities?.allObjects as? [TaskEntity] ?? [] {
                guard let task = goal.tasks.first(where: { $0.id == taskEntity.id }) else {
                    continue
                }
                taskEntity.name = task.name
                taskEntity.isCompleted = task.isCompleted
            }
            
            save()
        } catch {
            print("Error updating goal's tasks: \(error)")
        }
    }
    
    private func deleteGoal(goal: Goal) {
        guard let goalEntity = savedGoalsEntities.first(where: { $0.id == goal.id }) else {
            print("Goal not found with ID: \(goal.id)")
            return
        }
        container.viewContext.delete(goalEntity)
        save()
    }
    
    private func save() {
        let request = NSFetchRequest<GoalEntity>(entityName: goalEntityName)
        
        if container.viewContext.hasChanges {
            do {
                savedGoalsEntities = try container.viewContext.fetch(request)
                try container.viewContext.save()
                
                allGoals = savedGoalsEntities.map { convertToGoal(goalEntity: $0) }
                
                print("Successfully saved to Core Data!")
            } catch let error {
                print("Error saving to Core Data. \(error)")
            }
        }
    }
    
    private func convertToGoal(goalEntity: GoalEntity) -> Goal {
        guard let taskEntities = goalEntity.taskEntities?.allObjects as? [TaskEntity] else {
            return Goal(id: goalEntity.id!,
                        name: goalEntity.name!,
                        createdAt: goalEntity.createdAt!,
                        tasks: [])
        }
        
        let tasks = taskEntities.map { convertToTask(taskEntity: $0) }
        
        return Goal(id: goalEntity.id!,
                    name: goalEntity.name!,
                    createdAt: goalEntity.createdAt!,
                    tasks: tasks)
    }

    private func convertToTask(taskEntity: TaskEntity) -> Task {
        return Task(id: taskEntity.id!,
                    name: taskEntity.name!,
                    isCompleted: taskEntity.isCompleted)
    }
    
    
    func checkLength(of text: String) throws {
        // check that the text is at least 3 characters long
        guard text.count > 0 else { throw NameLengthError.empty }
        guard text.count >= 3 else { throw NameLengthError.short }
    }
    
}

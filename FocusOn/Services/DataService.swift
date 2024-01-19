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
            let savedGoalsEntities = try container.viewContext.fetch(request)
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
    
    func updateTask(goal: Goal, task: Task, name: String, isCompleted: Bool, index: Int) throws {
        // Check if goal exists
        let request = NSFetchRequest<GoalEntity>(entityName: goalEntityName)
        request.predicate = NSPredicate(format: "id == %@", goal.id as CVarArg)
        
        do {
            let result = try container.viewContext.fetch(request)
            guard let goalEntity = result.first else {
                print("Goal not found for ID: \(goal.id)")
                return
            }
            
            // Update existing tasks
            guard let taskEntity = goalEntity.taskEntities![index] as? TaskEntity else {
                print("Task not found for ID: \(task.id)")
                return
            }
            
            taskEntity.name = name
            taskEntity.isCompleted = isCompleted
            
            save()
        } catch {
            print("Error updating goal's tasks: \(error)")
        }
    }
    
    func deleteGoal(goal: Goal) throws {
        guard let goalEntity = savedGoalsEntities.first(where: { $0.id == goal.id }) else {
            print("Goal not found with ID: \(goal.id)")
            return
        }
        container.viewContext.delete(goalEntity)
        save()
    }
    
    // MARK: PRIVATE
    
    private func createNewGoalEntity(from goal: Goal) {
        // Create new goal entity
        let goalEntity = GoalEntity(context: container.viewContext)
        goalEntity.id = goal.id
        goalEntity.name = goal.name
        goalEntity.createdAt = goal.createdAt
        
        // Add tasks to new goal entity
        addTasksTo(goalEntity: goalEntity, goalTasks: goal.tasks)
        save()
    }
    
    private func addTasksTo(goalEntity: GoalEntity, goalTasks: [Task]) {
        for task in goalTasks {
            let taskEntity = TaskEntity(context: container.viewContext)
            taskEntity.id = task.id
            taskEntity.name = task.name
            taskEntity.isCompleted = task.isCompleted
            
            // Set the relationship between TaskEntity and GoalEntity
            taskEntity.goalEntity = goalEntity
        }
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
    
    private func updateTasksForGoal(goal: Goal) {
        // Check if goal exists
        let request = NSFetchRequest<GoalEntity>(entityName: goalEntityName)
        request.predicate = NSPredicate(format: "id == %@", goal.id as CVarArg)
        
        do {
            let result = try container.viewContext.fetch(request)
            guard let goalEntity = result.first else {
                print("Goal not found for ID: \(goal.id)")
                return
            }
            
            // Update existing tasks
            for (taskEntity, task) in zip(goalEntity.taskEntities!, goal.tasks) {
                guard let taskEntity = taskEntity as? TaskEntity else {
                    print("Task not found for ID: \(task.id)")
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
        guard let taskEntities = goalEntity.taskEntities?.array as? [TaskEntity] else {
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
}

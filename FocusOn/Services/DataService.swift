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
    
    func upsertGoal(goal: Goal) throws {
        let request = NSFetchRequest<GoalEntity>(entityName: goalEntityName)
        request.predicate = NSPredicate(format: "id == %@", goal.id as CVarArg)
        
        do {
            let result = try container.viewContext.fetch(request)
            // Check if goal entity already exists
            if let goalEntity = result.first {
                update(goalEntity: goalEntity, from: goal)
            } else {
                createNewGoalEntity(from: goal)
            }
            save()
            
        } catch {
            print("Error fetching or saving a goal: \(error)")
        }
    }
    
    func updateTask(task: Task) throws {
        let request = NSFetchRequest<TaskEntity>(entityName: taskEntityName)
        request.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
        
        do {
            let result = try container.viewContext.fetch(request)
            if let entity = result.first {
                entity.name = task.name
                entity.isCompleted = task.isCompleted
            }
            save()
            
        } catch let error {
            print("Error fetching or saving a task: \(error)")
        }
    }
    
    // MARK: PRIVATE
    
    private func createNewGoalEntity(from goal: Goal) {
        // Create new goal entity
        let newGoalEntity = GoalEntity(context: container.viewContext)
        newGoalEntity.id = goal.id
        newGoalEntity.name = goal.name
        newGoalEntity.createdAt = goal.createdAt
        
        // Add tasks to new goal entity
        addTasksToNewGoal(goalEntity: newGoalEntity, goalTasks: goal.tasks)
    }
    
    private func update(goalEntity: GoalEntity, from goal: Goal) {
        // Update the goal's name
        goalEntity.name = goal.name
        
        // Update existing tasks
        updateTasksForGoal(goal: goal)
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
            if let updatedGoalEntity = result.first {
                for taskEntity in updatedGoalEntity.taskEntities?.allObjects as! [TaskEntity] {
                    for task in goal.tasks {
                        if taskEntity.id == task.id {
                            taskEntity.name = task.name
                            taskEntity.isCompleted = task.isCompleted
                        }
                    }
                }
            }
        } catch {
            print("Error upading goal's tasks: \(error)")
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
        do {
            try container.viewContext.save()
            allGoals = fetchGoals()
            
            print("Successfully saved to Core Data!")
        } catch let error {
            print("Error saving to Core Data. \(error)")
        }
    }
    
    private func convertToGoal(goalEntity: GoalEntity) -> Goal {
        let tasks = (goalEntity.taskEntities?.allObjects as? [TaskEntity])?.map { convertToTask(taskEntity: $0) } ?? []
        
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

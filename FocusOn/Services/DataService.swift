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
    var savedGoals: [GoalEntity] = []
    
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
            savedGoals = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching! \(error)")
        }
        
        return savedGoals.map { convertToGoal(goalEntity: $0) }
    }
    
    func upsertGoal(goal: Goal, name: String) throws{
        try checkLength(of: goal.name)
        
        // Check if goal already exists
        let request = NSFetchRequest<GoalEntity>(entityName: goalEntityName)
        request.predicate = NSPredicate(format: "id == %@", goal.id as CVarArg)

        do {
            let result = try container.viewContext.fetch(request)

            if let entity = result.first {
                // Update existing goal
                entity.name = name
                entity.completionStatus = goal.isCompleted
            } else {
                // Create new goal
                let entity = GoalEntity(context: container.viewContext)
                entity.id = goal.id
                entity.name = name
                entity.createdAt = goal.createdAt
                entity.completionStatus = goal.isCompleted
                entity.tasks = NSSet(array: goal.tasks) as NSSet?
            }
            save()
            
        } catch {
            print("Error fetching or saving a goal: \(error)")
        }
    }
    
    func updateTask(task: Task, name: String, isCompleted: Bool = false) throws{
        try checkLength(of: task.name)
        
        let request = NSFetchRequest<TaskEntity>(entityName: taskEntityName)
        request.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
        
        do {
            let result = try container.viewContext.fetch(request)
            if let entity = result.first {
                entity.name = name
                entity.completionStatus = isCompleted
                save()
            }
        } catch let error {
            print("Error fetching or saving a task: \(error)")
        }
    }
    
    // MARK: PRIVATE
    
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
        return Goal(id: goalEntity.id!,
                    name: goalEntity.name!,
                    createdAt: goalEntity.createdAt!,
                    tasks: goalEntity.tasks?.allObjects as! [Task])
    }
    
    func checkLength(of text: String) throws {
        // check that the text is at least 3 characters long
        guard text.count > 0 else { throw NameLengthError.empty }
        guard text.count >= 3 else { throw NameLengthError.short }
    }

}

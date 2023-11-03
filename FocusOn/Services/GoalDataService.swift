//
//  GoalDataService.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 06/04/2022.
//

import Foundation
import CoreData

class GoalDataService: DataServiceProtocol {
    var allGoals: [Goal]?
    let container: NSPersistentContainer
    private let containerName: String = "FocusOn"
    private let goalEntityName: String = "GoalEntity"
    @Published var savedGoals: [GoalEntity] = []

    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Error loading Core Data! \(error)")
            } else {
                print("Successfully loaded core data!")
//                self.fetchGoals()
            }
        })
    }

    // MARK: PUBLIC

    func upsertGoals(goal: Goal, name: String) {
        // check if gaol already exists
        if let entity = savedGoals.first(where: { $0.id == goal.id }) {
            if name != "" {
                update(entity: entity, name: name)
            } else {
                delete(entity: entity)
            }
        } else {
            add(goal: goal, name: name)
        }
    }

    // MARK: TOFIX
    func fetchGoals() -> [Goal]{
        let request = NSFetchRequest<GoalEntity>(entityName: goalEntityName)
        do {
            savedGoals = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching! \(error)")
        }
        return []
    }

    func insertGoal(goal:Goal) { }
    func updateGoal(goal: Goal, name: String) { }
    func updateTask(task: Task, name: String, isCompleted: Bool = false) { }

    // MARK: PRIVATE

    private func add(goal: Goal, name: String) {
        let entity = GoalEntity(context: container.viewContext)
        entity.id = goal.id
        entity.name = name
        entity.createdAt = goal.createdAt
        entity.completionStatus = goal.isCompleted
        entity.tasks = NSSet(array: goal.tasks) as NSSet?
        save()
    }

    private func update(entity: GoalEntity, name: String) {
        entity.name = name
        save()
    }

    private func delete(entity: GoalEntity) {
        container.viewContext.delete(entity)
        save()
    }

    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data. \(error)")
        }
    }
}

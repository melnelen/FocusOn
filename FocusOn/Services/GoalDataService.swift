//
//  GoalDataService.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 06/04/2022.
//

import Foundation
import CoreData

class GoalDataService: DataServiceProtocol {

    // Singleton
    //    static let shared = GoalDataService()

    let container: NSPersistentContainer
    
    private let containerName: String = "FocusOn"
    private let goalEntityName: String = "GoalMO"

    @Published var savedGoals: [GoalMO] = []

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

    func upsertGoals(goal: Goal, name: String, isCompleted: Bool) {
        // check if gaol already exists
        if let entity = savedGoals.first(where: { $0.id == goal.id }) {
            if name != "" {
                update(entity: entity, name: name, isCompleted: isCompleted)
            } else {
                delete(entity: entity)
            }
        } else {
            add(goal: goal, name: name)
        }
    }

    // MARK: TOFIX
    func fetchGoals() -> [Goal]{
        let request = NSFetchRequest<GoalMO>(entityName: goalEntityName)
        do {
            savedGoals = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching! \(error)")
        }
        return []
    }

    func insertGoal(goal:Goal) { }
    func updateGoal(goal: Goal, name: String, isCompleted: Bool) { }

    // MARK: PRIVATE

    private func add(goal: Goal, name: String) {
        let entity = GoalMO(context: container.viewContext)
        entity.id = goal.id
        entity.name = name
        entity.createdAt = goal.createdAt
        entity.isCompleted = goal.isCompleted
        entity.tasks = goal.tasks as NSSet?
        applyChanges()
    }

    private func update(entity: GoalMO, name: String, isCompleted: Bool) {
        entity.name = name
        entity.isCompleted = isCompleted
        applyChanges()
    }

    private func delete(entity: GoalMO) {
        container.viewContext.delete(entity)
        applyChanges()
    }

    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data. \(error)")
        }
    }

    private func applyChanges() {
        save()
//        fetchGoals()
    }
}

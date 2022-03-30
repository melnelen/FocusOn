//
//  Persistence.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 23/12/2021.
//

import CoreData

class PersistenceController {

    // Singleton
    static let shared = PersistenceController()

    let container: NSPersistentContainer
    
    private let containerName: String = "FocusOn"
    private let goalEntityName: String = "Goal"
    private let taskEntityName: String = "Task"

    @Published var goals: [Goal] = []
    @Published var tasks: [Task] = []

    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Error loading Core Data! \(error)")
            } else {
                print("Successfully loaded core data!")
                self.fetchGoals()
                self.fetchTasks()
            }
        })
    }

    func fetchGoals() {
        let request = NSFetchRequest<Goal>(entityName: goalEntityName)
        do {
            goals = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching! \(error)")
        }
    }

    func addGoal(text: String) {
        let newGoal = Goal(context: container.viewContext)
        newGoal.id = UUID()
        newGoal.name = text
        newGoal.createdAt = Date()
        newGoal.completionStatus = false
        newGoal.tasks = [Task(), Task(), Task()]
        saveData()
    }

    func updateGoalName(entity: Goal, text: String) {
        let newGoalName = text
        entity.name = newGoalName
        saveData()
    }

    func updateGoalCompletionStatus(entity: Goal, completionStatus: Bool) {
        let newGoalCompletionStatus = completionStatus
        entity.completionStatus = newGoalCompletionStatus
        saveData()
    }

    func fetchTasks() {
        let request = NSFetchRequest<Task>(entityName: taskEntityName)
        do {
            tasks = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching! \(error)")
        }
    }

    func addTask(text: String) {
        let newTask = Task(context: container.viewContext)
        newTask.id = UUID()
        newTask.name = text
        newTask.completionStatus = false
        saveData()
    }

    func updateTaskName(entity: Task, text: String) {
        let newTaskName = text
        entity.name = newTaskName
        saveData()
    }

    func updateTaskCompletionStatus(entity: Task, completionStatus: Bool) {
        let newTaskCompletionStatus = completionStatus
        entity.completionStatus = newTaskCompletionStatus
        saveData()
    }

    func saveData() {
        do {
            try container.viewContext.save()
            fetchGoals()
            fetchTasks()
        } catch let error {
            print("Error saving! \(error)")
        }
    }
}

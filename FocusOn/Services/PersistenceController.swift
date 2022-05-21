////
////  Persistence.swift
////  FocusOn
////
////  Created by Alexandra Ivanova on 23/12/2021.
////
//
//import CoreData
//
// MARK: TOREMOVE
//class PersistenceController {
//
//    // Singleton
//    static let shared = PersistenceController()
//
//    let container: NSPersistentContainer
//
//    private let containerName: String = "FocusOn"
//    private let goalEntityName: String = "GoalMO"
//    private let taskEntityName: String = "TaskMO"
//
//    @Published var goals: [GoalMO] = []
//    @Published var tasks: [TaskMO] = []
//
//    init() {
//        container = NSPersistentContainer(name: containerName)
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Error loading Core Data! \(error)")
//            } else {
//                print("Successfully loaded core data!")
//                self.fetchGoals()
//                self.fetchTasks()
//            }
//        })
//    }
//
//    func fetchGoals() {
//        let request = NSFetchRequest<GoalMO>(entityName: goalEntityName)
//        do {
//            goals = try container.viewContext.fetch(request)
//        } catch let error {
//            print("Error fetching! \(error)")
//        }
//    }
//
//    func addGoal(text: String) {
//        let newGoal = GoalMO(context: container.viewContext)
//        newGoal.id = UUID()
//        newGoal.name = text
//        newGoal.createdAt = Date()
//        newGoal.isCompleted = false
//        newGoal.tasks = Set<Task>() as NSSet?
//        saveData()
//    }
//
//    func updateGoalName(entity: GoalMO, text: String) {
//        let newGoalName = text
//        entity.name = newGoalName
//        saveData()
//    }
//
//    func updateGoalCompletionStatus(entity: GoalMO, completionStatus: Bool) {
//        let newGoalCompletionStatus = completionStatus
//        entity.isCompleted = newGoalCompletionStatus
//        saveData()
//    }
//
//    func fetchTasks() {
//        let request = NSFetchRequest<TaskMO>(entityName: taskEntityName)
//        do {
//            tasks = try container.viewContext.fetch(request)
//        } catch let error {
//            print("Error fetching! \(error)")
//        }
//    }
//
//    func addTask(text: String) {
//        let newTask = TaskMO(context: container.viewContext)
//        newTask.id = UUID()
//        newTask.name = text
//        newTask.isCompleted = false
//        saveData()
//    }
//
//    func updateTaskName(entity: TaskMO, text: String) {
//        let newTaskName = text
//        entity.name = newTaskName
//        saveData()
//    }
//
//    func updateTaskCompletionStatus(entity: TaskMO, completionStatus: Bool) {
//        let newTaskCompletionStatus = completionStatus
//        entity.isCompleted = newTaskCompletionStatus
//        saveData()
//    }
//
//    func saveData() {
//        do {
//            try container.viewContext.save()
//            fetchGoals()
//            fetchTasks()
//        } catch let error {
//            print("Error saving! \(error)")
//        }
//    }
//}

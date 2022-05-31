//
//  TodayView-ViewModel.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 25/03/2022.
//

import Foundation
import Combine

class TodayViewModel: ObservableObject {
    @Published var todayGoal = Goal()
    @Published var allGoals: [Goal]?
    private let dataService: DataServiceProtocol
    //    private var cancellables = Set<AnyCancellable>()

    //    init() {
    //        updateAllGoals()
    //    }

    init( dataService: DataServiceProtocol = MockDataService()) {
        self.dataService = dataService
    }

    // MARK: TODO
    func updateAllGoals() {
        //        $allGoals
        //            .combineLatest(dataService.$savedGoals)
        //            .map { (allGoals, goalsMO) -> [Goal] in
        //                allGoals.compactMap { (goal) -> Goal? in
        //                    guard let entity = goalsMO.first(where: { $0.id == goal.id }) else {
        //                        return nil
        //                    }
        //                    return goal.updateGoal(name: entity.name!, isCompleted: entity.isCompleted)
        //                }
        //            }
        //            .sink { [weak self] (returnedGoals) in
        //                self?.allGoals =  returnedGoals
        //            }
        //            .store(in: &cancellables)
    }

    func fetchGoals() -> [Goal]? {
        allGoals = dataService.allGoals
        return allGoals
    }

    func addGoal(name: String) throws {
        todayGoal.name = name
        try dataService.insertGoal(goal: todayGoal)
    }

    func updateGoal(goal: Goal, name: String, isCompleted: Bool = false) throws {
        goal.name = name
        goal.isCompleted = isCompleted
        try dataService.updateGoal(goal: goal, name: name, isCompleted: isCompleted)
    }

    func updateTask(task: Task, name: String, isCompleted: Bool = false) throws {
        task.name = name
        task.isCompleted = isCompleted
        try dataService.updateTask(task: task, name: name, isCompleted: isCompleted)
    }

    func checkGoalIsCompleted(goal: Goal) {
        if (goal.isCompleted) {
            goal.isCompleted = false
            goal.tasks.forEach { task in
                task.isCompleted = false
            }
        } else {
            goal.isCompleted = true
            goal.tasks.forEach { task in
                task.isCompleted = true
            }
        }
    }

    func checkTaskIsCompleted(goal: Goal, task: Task) {
        task.isCompleted = !task.isCompleted
        goal.isCompleted = true
        goal.tasks.forEach { task in
            if (!task.isCompleted) {
                goal.isCompleted = false
            }
        }
    }
}

// MARK: TRASH

//    func currentGoal() -> Goal? {
//        dataService.fetchGoals().first
//    }

//        let goal = Goal()
//                name: name,
//                isCompleted: false,
//                tasks: [Task(), Task(), Task()])
//        todayGoal.tasks =  [Task(), Task(), Task()]

// @State private var tasksText = ["", "", ""]
// @State private var tasksAreCompleted: [Bool] = [false, false, false]
// @State private var index = 0

//                    ForEach(Array(goal.tasks), id: \.self) { task in
//                        HStack {
//                            TextField("My task is to ...", text: $tasksText[Array(goal.tasks).firstIndex(of: task)])
//                            Button(
//                                action: {
//                                    let index = Array(goal.tasks).firstIndex(of: task)
//                                    viewModel.checkTaskIsCompleted(goal: goal, task: task)
//                                    tasksAreCompleted[index] = task.isCompleted
//                                    viewModel.updateTask(task: task, name: tasksText[index], isCompleted: tasksAreCompleted[index])
//                                    goalIsCompleted = goal.isCompleted
//                                }) {
//                                    Image(systemName: (tasksAreCompleted[Array(goal.tasks).firstIndex(of: task)] ? "checkmark.circle.fill" : "circle"))
//                                        .foregroundColor(tasksAreCompleted[Array(goal.tasks).firstIndex(of: task)] ? Color("SuccessColor") : .black)
//                                }
//                        }
//                    }

//    private mutating func updateCurrentGoal(goal: Goal) {
//        if let goal = viewModel.allGoals.first(where: { $0.id == goal.id }) {
//            textPlaceholder = goal.name
//        } else {
//            textPlaceholder = ""
//        }
//    }

//    private func taskCheckboxPressed(goal: Goal, task: Task, text: String, status: Bool) -> Bool {
//        // check the current completion status of the task
//       viewModel.checkTaskIsCompleted(goal: goal, task: task)
//        task.isCompleted = !task.isCompleted
//
//        // update the state of the checkbox
//        let newStatus = task.isCompleted
//
//        // update the goal with the new values
//        viewModel.updateTask(task: task, name: text, isCompleted: task.isCompleted)
//
//        return task.isCompleted
//    }


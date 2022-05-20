//
//  TodayView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 03/02/2022.
//

import SwiftUI

struct TodayView: View {
    @StateObject var viewModel = TodayViewModel()

    @State private var todayGoal: Goal?
    @State private var goalText = ""
    @State private var tasksText = ["", "", ""]
    @State private var goalIsCompleted = false
    @State private var tasksAreCompleted = [false, false, false]

    var body: some View {
        Form {

            Section {
                HStack {
                    TextField("My goal is to ...", text: $goalText)
                    if let goal = todayGoal {
                        Button(
                            action: {
                                goalCheckboxPressed(goal: goal)
                            }) {
                                Image(systemName: (goalIsCompleted ? "checkmark.circle.fill" : "circle"))
                                    .foregroundColor(goalIsCompleted ? Color("SuccessColor") : .black)
                            }
                    } else {
                        Button(
                            action: {
                                addGoalButtonPressed()
                            }, label: {
                                Text("Add")
                            })
                    }
                }
            } header: {
                Text("What is your goal for today?")
            }

            Section {
                if let goal = todayGoal {
                    HStack {
                        TextField("My first task is to ...", text: $tasksText[0])
                        Button(
                            action: {
                                let task = Array(goal.tasks)[0]
                                taskCheckboxPressed(goal: goal, task: task)
                            }) {
                                Image(systemName: (tasksAreCompleted[0] ? "checkmark.circle.fill" : "circle"))
                                    .foregroundColor(tasksAreCompleted[0] ? Color("SuccessColor") : .black)
                            }
                    }
                    HStack {
                        TextField("My second task is to ...", text: $tasksText[1])
                        Button(
                            action: {
                                let task = Array(goal.tasks)[1]
                                taskCheckboxPressed(goal: goal, task: task)
                            }) {
                                Image(systemName: (tasksAreCompleted[1] ? "checkmark.circle.fill" : "circle"))
                                    .foregroundColor(tasksAreCompleted[1] ? Color("SuccessColor") : .black)
                            }
                    }
                    HStack {
                        TextField("My third task is to ...", text: $tasksText[2])
                        Button(
                            action: {
                                let task = Array(goal.tasks)[2]
                                taskCheckboxPressed(goal: goal, task: task)
                            }) {
                                Image(systemName: (tasksAreCompleted[2] ? "checkmark.circle.fill" : "circle"))
                                    .foregroundColor(tasksAreCompleted[2] ? Color("SuccessColor") : .black)
                            }
                    }
                }
            } header: {
                Text("What are the three tasks to achieve it?")
            }
        }
        .navigationTitle("FocusOn")
        .environmentObject(viewModel)
//      .onAppear { currentGoal = viewModel.todayGoal }
        
    }
}

extension TodayView {
    private func addGoalButtonPressed() {
        // link view goal to the viewModel goal
        todayGoal = viewModel.todayGoal

        // add the goal to the list of goals
        viewModel.addGoal(name: goalText)

        // hide keyboard
        UIApplication.shared.endEditing()
    }

    private func goalCheckboxPressed(goal: Goal) {
        // check the current completion status of the goal
        viewModel.checkGoalIsCompleted(goal: goal)

        // update the state of the checkbox
        goalIsCompleted = goal.isCompleted

        // update the goal with the new values
        viewModel.updateGoal(goal: goal, name: goalText, isCompleted: goalIsCompleted)

        // update the tasks checkboxes with the new values
        tasksAreCompleted[0] = Array(goal.tasks)[0].isCompleted
        tasksAreCompleted[1] = Array(goal.tasks)[1].isCompleted
        tasksAreCompleted[2] = Array(goal.tasks)[2].isCompleted
    }

    private func taskCheckboxPressed(goal: Goal, task: Task) {
        // get the index of the task at hand
        let index = Array(goal.tasks).firstIndex(of: task)

        // check the current completion status of the task
        viewModel.checkTaskIsCompleted(goal: goal, task: task)

        // update the state of the checkbox
        tasksAreCompleted[index!] = task.isCompleted

        // update the task with the new values
        viewModel.updateTask(task: task, name: tasksText[index!], isCompleted: tasksAreCompleted[index!])

        // update the goal checkbox
        goalIsCompleted = goal.isCompleted
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
            .environmentObject(TodayViewModel())
    }
}

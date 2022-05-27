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
    @State private var nameIsLongEnough = false
    @State private var showAlert = false

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
                .alert(isPresented: $showAlert) { showNameLengthAlert() }
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
                    .alert(isPresented: $showAlert) { showNameLengthAlert() }
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
                    .alert(isPresented: $showAlert) { showNameLengthAlert() }
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
                    .alert(isPresented: $showAlert) { showNameLengthAlert() }
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
        // check that the name of the goal is at least 3 characters long
        nameIsLongEnough = viewModel.checkLength(of: goalText)
        if nameIsLongEnough {
            // link view goal to the viewModel goal
            todayGoal = viewModel.todayGoal

            // add the goal to the list of goals
            viewModel.addGoal(name: goalText)

            // update the text for the goal name
            goalText = viewModel.todayGoal.name

            // hide keyboard
            UIApplication.shared.endEditing()
        } else {
            showAlert.toggle()
        }
    }

    private func goalCheckboxPressed(goal: Goal) {
        // check that the name of the goal is at least 3 characters long
        nameIsLongEnough = (viewModel.checkLength(of: goalText) &&
                            viewModel.checkLength(of: tasksText[0]) &&
                            viewModel.checkLength(of: tasksText[1]) &&
                            viewModel.checkLength(of: tasksText[2]))
        if nameIsLongEnough {
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
        } else {
            showAlert.toggle()
        }
    }

    private func taskCheckboxPressed(goal: Goal, task: Task) {
        // get the index of the task at hand
        let index = Array(goal.tasks).firstIndex(of: task)
        // check that the name of the goal is at least 3 characters long
        nameIsLongEnough = viewModel.checkLength(of: tasksText[index!])
        if nameIsLongEnough {
            // check the current completion status of the task
            viewModel.checkTaskIsCompleted(goal: goal, task: task)

            // update the state of the checkbox
            tasksAreCompleted[index!] = task.isCompleted

            // update the task with the new values
            viewModel.updateTask(task: task, name: tasksText[index!], isCompleted: tasksAreCompleted[index!])

            // update the goal checkbox
            goalIsCompleted = goal.isCompleted
        } else {
            showAlert.toggle()
        }
    }

    private func showNameLengthAlert() -> Alert{
        Alert(title: Text("Oops 🙊"),
              message: Text("Please, make sure that the name of your goal and all of your tasks are at least 3 characters long"),
              dismissButton: .default(Text("OK")))
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
            .environmentObject(TodayViewModel())
    }
}

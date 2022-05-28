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
        do {
            // add the goal to the list of goals
            try viewModel.addGoal(name: goalText)

            // link view goal to the viewModel goal
            todayGoal = viewModel.todayGoal

            // update the text for the goal name
            goalText = viewModel.todayGoal.name
        } catch NameLengthError.empty, NameLengthError.short {
            showAlert.toggle()
        } catch {
            print("Something went wrong!")
        }

        // hide keyboard
        UIApplication.shared.endEditing()
    }

    private func goalCheckboxPressed(goal: Goal) {
        do {
            // update the goal and the tasks with the new values
            try viewModel.updateGoal(goal: goal, name: goalText, isCompleted: goalIsCompleted)
            try viewModel.updateTask(task: Array(goal.tasks)[0], name: tasksText[0], isCompleted: tasksAreCompleted[0])
            try viewModel.updateTask(task: Array(goal.tasks)[1], name: tasksText[1], isCompleted: tasksAreCompleted[1])
            try viewModel.updateTask(task: Array(goal.tasks)[2], name: tasksText[2], isCompleted: tasksAreCompleted[2])

            // check the current completion status of the goal
            viewModel.checkGoalIsCompleted(goal: goal)

            // update the state of the checkbox
            goalIsCompleted = goal.isCompleted

            // update the tasks checkboxes with the new values
            tasksAreCompleted[0] = Array(goal.tasks)[0].isCompleted
            tasksAreCompleted[1] = Array(goal.tasks)[1].isCompleted
            tasksAreCompleted[2] = Array(goal.tasks)[2].isCompleted
        } catch NameLengthError.empty, NameLengthError.short {
            showAlert.toggle()
        } catch {
            print("Something went wrong!")
        }
    }

    private func taskCheckboxPressed(goal: Goal, task: Task) {
        // get the index of the task at hand
        let index = Array(goal.tasks).firstIndex(of: task)
        do {
            // update the task with the new values
            try viewModel.updateTask(task: task, name: tasksText[index!], isCompleted: tasksAreCompleted[index!])

            // check the current completion status of the task
            viewModel.checkTaskIsCompleted(goal: goal, task: task)

            // update the state of the checkbox
            tasksAreCompleted[index!] = task.isCompleted

            // update the goal checkbox
            goalIsCompleted = goal.isCompleted
        } catch NameLengthError.empty, NameLengthError.short {
            showAlert.toggle()
        } catch {
            print("Something went wrong!")
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

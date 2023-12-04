//
//  TodayView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 03/02/2022.
//

import SwiftUI

struct TodayView: View {
    @StateObject var viewModel = TodayViewModel()
    
    @State private var lastGoal: Goal?
    @State private var todayGoal: Goal?
    @State private var goalText = ""
    @State private var tasksText = ["", "", ""]
    @State private var goalIsCompleted = false
    @State private var tasksAreCompleted = [false, false, false]
    @State private var showAlert = false
    @State private var isShowingTaskCompletionAnimation = false
    @State private var isShowingTaskUncheckAnimation = false
    @State private var isShowingGoalCompletionAnimation = false
    
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
                                Image(systemName: (goalIsCompleted ? "checkmark.seal.fill" : "circle"))
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
                .font(.system(size: 25))
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
        .onAppear {
            fetchLastGoal()
            checkForDailySetup()
        }
        .alert(isPresented: $showAlert) { showLastGoalNotCompletedAlert() }
        .overlay(
            TaskCompletionView()
                .opacity(isShowingTaskCompletionAnimation ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 1.0))
        )
        .overlay(
            TaskUncheckView()
                .opacity(isShowingTaskUncheckAnimation ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 1.0))
        )
        .overlay(
            GoalCompletionView()
                .opacity(isShowingGoalCompletionAnimation ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 1.0))
        )
        .overlay(
            ConfettiView()
                .opacity(isShowingGoalCompletionAnimation ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 1.5))
        )
    }
}

extension TodayView {
    private func addGoalButtonPressed() {
        do {
            // add the goal to the list of goals
            try viewModel.addNewGoal(name: goalText)
            
            // link view goal to the viewModel goal
            todayGoal = viewModel.todayGoal
            
            // update the text for the goal name
            goalText = todayGoal?.name ?? ""
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
            try viewModel.updateGoal(goal: goal, name: goalText)
//            try viewModel.updateTask(task: Array(goal.tasks)[0], name: tasksText[0], isCompleted: tasksAreCompleted[0])
//            try viewModel.updateTask(task: Array(goal.tasks)[1], name: tasksText[1], isCompleted: tasksAreCompleted[1])
//            try viewModel.updateTask(task: Array(goal.tasks)[2], name: tasksText[2], isCompleted: tasksAreCompleted[2])
            
            // check the current completion status of the goal
            viewModel.checkGoalIsCompleted(goal: goal)
            
            // update the state of the checkbox
            goalIsCompleted = goal.isCompleted
            
            // update the tasks checkboxes with the new values
            tasksAreCompleted[0] = Array(goal.tasks)[0].isCompleted
            tasksAreCompleted[1] = Array(goal.tasks)[1].isCompleted
            tasksAreCompleted[2] = Array(goal.tasks)[2].isCompleted
            
            // Show the goal completion animation
            if goal.isCompleted {
                isShowingGoalCompletionAnimation = true
            }
            
            // Reset the animation state after a short delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                isShowingGoalCompletionAnimation = false
            }
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
            
            // Show the task completion animation
            if task.isCompleted && !goal.isCompleted {
                isShowingTaskCompletionAnimation = true
            } else if !task.isCompleted {
                isShowingTaskUncheckAnimation = true
            }
            
            // Reset the animation state after a short delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                isShowingTaskCompletionAnimation = false
            }
            
            // Reset the animation state after a short delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                isShowingTaskUncheckAnimation = false
            }
            
            // update the goal checkbox
            goalIsCompleted = goal.isCompleted
            
            // Show the goal completion animation
            if goal.isCompleted {
                isShowingGoalCompletionAnimation = true
            }
            
            // Reset the animation state after a short delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                isShowingGoalCompletionAnimation = false
            }
        } catch NameLengthError.empty, NameLengthError.short {
            showAlert.toggle()
        } catch {
            print("Something went wrong!")
        }
    }
    
    private func showNameLengthAlert() -> Alert {
        Alert(title: Text("Oops 🙊"),
              message: Text("Please, make sure that the name of your goal and all of your tasks are at least 3 characters long"),
              dismissButton: .default(Text("OK")))
    }
    
    private func checkForDailySetup() {
        let calendar = Calendar.current
        
        if let lastGoal = lastGoal {
            if !calendar.isDateInToday(lastGoal.createdAt) &&
                lastGoal.isCompleted == false {
                showAlert = true
            }
        }
    }
    
    private func continueLastGoalButtonPressed() {
        guard let lastGoal = lastGoal else {
            print("There a no goals!")
            return
        }
        todayGoal = lastGoal
        goalText = todayGoal!.name
        tasksText =
        [Array(todayGoal!.tasks)[0].name,
         Array(todayGoal!.tasks)[1].name,
         Array(todayGoal!.tasks)[2].name]
        tasksAreCompleted =
        [Array(todayGoal!.tasks)[0].isCompleted,
         Array(todayGoal!.tasks)[1].isCompleted,
         Array(todayGoal!.tasks)[2].isCompleted]
    }
    
    private func showLastGoalNotCompletedAlert() -> Alert {
        Alert(
            title: Text("Set up your goal for the day"),
            message: Text("Do you want to set up a new goal or continue working on the previous one?"),
            primaryButton: .default(Text("Set up new goal")) {
                // Set up a new goal
                addGoalButtonPressed()
            },
            secondaryButton: .default(Text("Continue previous goal")) {
                // Continue the previous goal
                continueLastGoalButtonPressed()
            }
        )
    }
    
}

extension TodayView {
    private func fetchLastGoal() {
        let calendar = Calendar.current
        
        lastGoal = viewModel.fetchGoals()?.last
        if let lastGoal = lastGoal {
            if calendar.isDateInToday(lastGoal.createdAt) {
                continueLastGoalButtonPressed()
            }
        }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
            .environmentObject(TodayViewModel())
    }
}

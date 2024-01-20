//
//  TasksSectionView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 14/12/2023.
//

import SwiftUI

struct TasksSectionView: View {
    @ObservedObject var viewModel: TodayViewModel
    
    @Binding var isShowingGoalCompletionAnimation: Bool
    @Binding var isShowingTaskCompletionAnimation: Bool
    @Binding var isShowingTaskUncheckAnimation: Bool
    let calendar = Calendar.current
    
    var body: some View {
        Section(header: Text("What are the three tasks to achieve it?")
            .bold()
            .font(.subheadline)
            .foregroundColor(.accentColor)) {
                if let lastGoal = viewModel.allGoals?.last {
                    if (calendar.isDateInToday(lastGoal.createdAt)) {
                        ForEach(Array(lastGoal.tasks.enumerated()), id: \.element) { index, task in
                            HStack {
//                                TextField("My task is to ...", text: $viewModel.tasksText[index])
                                TextField("My task is to ...", text: $viewModel.tasksText[index], onEditingChanged: { editingChanged in
                                    if !editingChanged {
                                        updateTaskName(goal: lastGoal, task: task, index: index)
                                    }
                                })
                                Button(action: {
                                    taskCheckboxPressed(goal: lastGoal, task: task)
//                                    updateTasksText()
//                                    updateTasksCheckboxes()
                                }) {
                                    Image(systemName: (viewModel.tasksAreCompleted[index] ? "checkmark.circle.fill" : "circle"))
                                        .foregroundColor(viewModel.tasksAreCompleted[index] ? Color("SuccessColor") : .accentColor)
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                setupTasksText()
                setupTasksCheckboxes()
            }
    }
}

extension TasksSectionView {
    private func updateTaskName(goal: Goal, task: Task, index: Int) {
        // Use a delay to update after the user stops typing
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            do {
                try viewModel.updateTask(goal: goal, task: task, name: viewModel.tasksText[index], isCompleted: task.isCompleted, index: index)
            } catch {
                print("Error updating goal: \(error)")
            }
        }
    }
    
    private func taskCheckboxPressed(goal: Goal, task: Task) {
        do {
            try viewModel.checkTaskIsCompleted(goal: goal, task: task)
            
            
            // Show the task completion animation
            if task.isCompleted && !goal.isCompleted {
                isShowingTaskCompletionAnimation = true
            } else if !task.isCompleted {
                isShowingTaskUncheckAnimation = true
            }
            
            // Show the goal completion animation
            if goal.isCompleted {
                isShowingGoalCompletionAnimation = true
            }
            
            // Reset the animation state after a short delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                isShowingTaskCompletionAnimation = false
                isShowingTaskUncheckAnimation = false
                isShowingGoalCompletionAnimation = false
            }
        } catch {
            print("Something went wrong!")
        }
    }
    
    private func setupTasksText() {
        guard let lastGoal = viewModel.allGoals?.last else {
            print("No goals found!")
            return
        }

        for (index, task) in lastGoal.tasks.enumerated() {
            viewModel.tasksText[index] = task.name
        }
    }
    
    private func setupTasksCheckboxes() {
        guard let lastGoal = viewModel.allGoals?.last else {
            print("No goals found!")
            return
        }
        
        for (index, task) in lastGoal.tasks.enumerated() {
            viewModel.tasksAreCompleted[index] = task.isCompleted
        }
    }
    
//    private func updateTasksText() {
//        for (index, _) in viewModel.tasksText.enumerated() {
//            viewModel.allGoals!.last!.tasks[index].name = viewModel.tasksText[index]
//        }
//    }
//    
//    private func updateTasksCheckboxes() {
//        for (index, _) in viewModel.tasksAreCompleted.enumerated() {
//            viewModel.allGoals!.last!.tasks[index].isCompleted = viewModel.tasksAreCompleted[index]
//        }
//    }
}

#Preview {
    TasksSectionView(viewModel: TodayView().viewModel, 
                     isShowingGoalCompletionAnimation: TodayView().$isShowingGoalCompletionAnimation,
                     isShowingTaskCompletionAnimation: TodayView().$isShowingTaskCompletionAnimation,
                     isShowingTaskUncheckAnimation: TodayView().$isShowingTaskUncheckAnimation)
}

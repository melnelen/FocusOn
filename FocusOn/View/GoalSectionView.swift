//
//  GoalSectionView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 14/12/2023.
//

import SwiftUI

struct GoalSectionView: View {
    @ObservedObject var viewModel: TodayViewModel
    
    @Binding var isShowingGoalCompletionAnimation: Bool
    let calendar = Calendar.current
    
    var body: some View {
        Section(header: Text("What is your goal for today?")
            .bold()
            .font(.headline)
            .foregroundColor(.accentColor)) {
                if let lastGoal = viewModel.allGoals?.last {
                    if (calendar.isDateInToday(lastGoal.createdAt)) {
                    Text("\(viewModel.formattedGoalDate(from: lastGoal.createdAt))")
                        .font(.caption)
                        .foregroundColor(Color.accentColor)
                        UpdateGoalView(
                            viewModel: viewModel,
                            isShowingGoalCompletionAnimation: $isShowingGoalCompletionAnimation)
                    } else {
                        AddGoalView(viewModel: viewModel)
                    }
                } else {
                    AddGoalView(viewModel: viewModel)
                }
            }
            .font(.system(size: 25))
    }
}

struct AddGoalView: View {
    @ObservedObject var viewModel: TodayViewModel
    
    var body: some View {
        HStack {
            TextField("My goal is to ...", text: $viewModel.goalText)
            Button(action: {
                addGoalButtonPressed()
            }) {
                Text("Add")
            }
        }
    }
}

extension AddGoalView {
    private func addGoalButtonPressed() {
        do {
            // Add the goal to the list of goals
            try viewModel.addNewGoal(name: viewModel.goalText)
            
        } catch {
            print("Something went wrong!")
        }
        
        // Hide keyboard
        UIApplication.shared.endEditing()
        
        
    }
}

struct UpdateGoalView: View {
    @ObservedObject var viewModel: TodayViewModel
    
    @Binding var isShowingGoalCompletionAnimation: Bool
    
    var body: some View {
        HStack {
            TextField("My goal is to ...", text: $viewModel.goalText, onEditingChanged: { editingChanged in
                if !editingChanged {
                    updateGoalName()
                }
            })
            Button(action: {
                goalCheckboxPressed()
            }) {
                Image(systemName: (viewModel.goalIsCompleted ? "checkmark.seal.fill" : "circle"))
                    .foregroundColor(viewModel.goalIsCompleted ? Color("SuccessColor") : .accentColor)
            }
        }
        .onAppear {
            setupGoalText()
            setupGoalCheckbox()
        }
    }
}

extension UpdateGoalView {
    private func updateGoalName() {
        // Use a delay to update after the user stops typing
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            do {
                guard let lastGoal = viewModel.allGoals?.last else {
                    print("No goals found!")
                    return
                }
                try viewModel.updateGoal(goal: lastGoal, name: viewModel.goalText, date: lastGoal.createdAt)
            } catch {
                print("Error updating goal: \(error)")
            }
        }
    }

    
    private func goalCheckboxPressed() {
        do {
            guard let lastGoal = viewModel.allGoals?.last else {
                print("No goals found!")
                return
            }
            
            try viewModel.checkGoalIsCompleted(goal: lastGoal)
            
            // Show the goal completion animation
            if viewModel.goalIsCompleted {
                isShowingGoalCompletionAnimation = true
            }
            
            // Reset the animation state after a short delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                isShowingGoalCompletionAnimation = false
            }
        } catch {
            print("Something went wrong!")
        }
    }
    
    private func setupGoalText() {
        guard let lastGoal = viewModel.allGoals?.last else {
            print("No goals found!")
            return
        }
        viewModel.goalText = lastGoal.name
    }
    
    private func setupGoalCheckbox() {
        guard let lastGoal = viewModel.allGoals?.last else {
            print("No goals found!")
            return
        }
        viewModel.goalIsCompleted = lastGoal.isCompleted
    }
}

#Preview {
    GoalSectionView(
        viewModel: TodayView().viewModel,
        isShowingGoalCompletionAnimation: TodayView().$isShowingGoalCompletionAnimation)
}

//
//  UpdateGoalView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 19/01/2024.
//

import SwiftUI

struct UpdateGoalView: View {
    @ObservedObject var viewModel: TodayViewModel
    
    @Binding var isShowingGoalCompletionAnimation: Bool
    @Binding var isShowingGoalUncheckAnimation: Bool
    
    var body: some View {
        HStack {
            TextField("My goal is to ...", text: $viewModel.goalText, onEditingChanged: { editingChanged in
                if !editingChanged {
                    updateGoalName()
                }
            })
            .accessibility(identifier: "MyUpdateGoalTextField")
            Button(action: {
                goalCheckboxPressed()
            }) {
                Image(systemName: (viewModel.goalIsCompleted ? "checkmark.seal.fill" : "circle"))
                    .foregroundColor(viewModel.goalIsCompleted ? Color("SuccessColor") : .accentColor)
            }
            .accessibility(identifier: "MyGoalCheckboxButton")
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
            if lastGoal.isCompleted {
                isShowingGoalCompletionAnimation = true
            } else if !lastGoal.isCompleted {
                isShowingGoalUncheckAnimation = true
            }
            
            // Reset the animation state after a short delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                isShowingGoalCompletionAnimation = false
                isShowingGoalUncheckAnimation = false
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
    UpdateGoalView(
        viewModel: TodayView().viewModel,
        isShowingGoalCompletionAnimation: TodayView().$isShowingGoalCompletionAnimation,
        isShowingGoalUncheckAnimation: TodayView().$isShowingGoalUncheckAnimation)
}

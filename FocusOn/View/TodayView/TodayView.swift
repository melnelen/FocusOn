//
//  TodayView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 03/02/2022.
//

import SwiftUI

struct TodayView: View {
    @StateObject var viewModel = TodayViewModel()
    
    @State private var showAlert = false
    @State var isShowingTaskCompletionAnimation = false
    @State var isShowingTaskUncheckAnimation = false
    @State var isShowingGoalCompletionAnimation = false
    @State var isShowingGoalUncheckAnimation = false
    let calendar = Calendar.current
    
    var body: some View {
        NavigationView {
            Form {
                GoalSectionView(
                    viewModel: viewModel,
                    isShowingGoalCompletionAnimation: $isShowingGoalCompletionAnimation,
                    isShowingGoalUncheckAnimation: $isShowingGoalUncheckAnimation)
                
                TasksSectionView(
                    viewModel: viewModel,
                    isShowingGoalCompletionAnimation: $isShowingGoalCompletionAnimation,
                    isShowingTaskCompletionAnimation: $isShowingTaskCompletionAnimation,
                    isShowingTaskUncheckAnimation: $isShowingTaskUncheckAnimation)
            }
            .navigationTitle("Today")
            .onAppear {
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
            .overlay(
                GoalUncheckView()
                    .opacity(isShowingGoalUncheckAnimation ? 1.0 : 0.0)
                    .animation(.easeInOut(duration: 1.5))
            )
            .overlay(
                SadFaceRainView()
                    .opacity(isShowingGoalUncheckAnimation ? 1.0 : 0.0)
                    .animation(.easeInOut(duration: 1.5))
            )
        }
    }
}

extension TodayView {
    private func showLastGoalNotCompletedAlert() -> Alert {
        Alert(
            title: Text("Set up your goal for the day"),
            message: Text("Do you want to set up a new goal or continue working on the previous one?"),
            primaryButton: .default(Text("Set up new goal")) {
                // Set up a new goal
            },
            secondaryButton: .default(Text("Continue previous goal")) {
                // Continue the previous goal
                continueLastGoalButtonPressed()
            }
        )
    }
    
    // TOFIX
    private func continueLastGoalButtonPressed() {
        guard let lastGoal = viewModel.allGoals?.last else {
            print("There are no goals!")
            return
        }
        
        do {
            viewModel.goalText = lastGoal.name
            viewModel.goalIsCompleted = lastGoal.isCompleted
            try viewModel.updateGoal(goal: lastGoal, name: viewModel.goalText, date: Date())
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
        guard let lastGoal = viewModel.allGoals?.last else {
            print("There are no goals!")
            return
        }
        
        if calendar.isDateInToday(lastGoal.createdAt) {
            return
        } else if (!calendar.isDateInToday(lastGoal.createdAt) &&
                   lastGoal.isCompleted == false) {
            showAlert = true
        }
    }
    
}

#Preview {
    TodayView()
}

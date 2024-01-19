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

#Preview {
    GoalSectionView(
        viewModel: TodayView().viewModel,
        isShowingGoalCompletionAnimation: TodayView().$isShowingGoalCompletionAnimation)
}

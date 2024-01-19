//
//  AddGoalView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 18/01/2024.
//

import SwiftUI

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

#Preview {
    AddGoalView(
        viewModel: TodayView().viewModel)
}

//
//  AddGoalView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 19/01/2024.
//

import SwiftUI

struct AddGoalView: View {
    @ObservedObject var viewModel: TodayViewModel
    
    var body: some View {
        HStack {
            TextField("My goal is to ...", text: $viewModel.goalText)
                .accessibility(identifier: "MyAddGoalTextField")
            Button(action: {
                addGoalButtonPressed()
            }) {
                Text("Add")
            }
            .accessibility(identifier: "AddGoalButton")
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

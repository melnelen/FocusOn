//
//  TodayView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 03/02/2022.
//

import SwiftUI

struct TodayView: View {
    @StateObject private var viewModel = TodayViewModel()

    var body: some View {
        Form {

            Section {
                HStack {
                    TextField("My goal is to ...", text: $viewModel.goal.name)
                    Button(
                        action: {
                            viewModel.checkGoalCompletionStatus()
                        }) {
                            Image(systemName: (viewModel.goal.completionStatus ? "checkmark.circle.fill" : "circle"))
                                .foregroundColor(viewModel.goal.completionStatus ? Color("SuccessColor") : .black)
                        }
                }
            } header: {
                Text("What is your goal for today?")
            }

            Section {
                ForEach(viewModel.goal.tasks.indices) { i in
                    HStack {
                        TextField("My task is to ...", text: $viewModel.goal.tasks[i].name)
                        Button(
                            action: {
                                viewModel.goal.tasks[i].completionStatus = (viewModel.goal.tasks[i].completionStatus ? false : true)
                                viewModel.checkAllTasksCompletionStatus()
                            }) {
                                Image(systemName: (viewModel.goal.tasks[i].completionStatus ? "checkmark.circle.fill" : "circle"))
                                    .foregroundColor(viewModel.goal.tasks[i].completionStatus ? Color("SuccessColor") : .black)
                            }
                    }
                }
            } header: {
                Text("What are the three tasks to achieve it?")
            }
        }
        .navigationTitle("FocusOn")
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}

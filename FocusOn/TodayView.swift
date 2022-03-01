//
//  TodayView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 03/02/2022.
//

import SwiftUI

struct TodayView: View {
    @State private var goal = Goal()

    var body: some View {
        Form {

            Section {
                GoalCreationView(
                    goal: $goal,
                    placeholder: "My goal is to ...",
                    name: $goal.name,
                    completionStatus: $goal.completionStatus)
            } header: {
                Text("What is your goal for today?")
            }

            Section {
                TaskCreationView(
                    goal: $goal,
                    task: $goal.tasks[0],
                    placeholder: "My first task is to ...",
                    name: $goal.tasks[0].name,
                    completionStatus: $goal.tasks[0].completionStatus)
                TaskCreationView(
                    goal: $goal,
                    task: $goal.tasks[1],
                    placeholder: "My second task is to ...",
                    name: $goal.tasks[1].name,
                    completionStatus: $goal.tasks[1].completionStatus)
                TaskCreationView(
                    goal: $goal,
                    task: $goal.tasks[2],
                    placeholder: "My third task is to ...",
                    name: $goal.tasks[2].name,
                    completionStatus: $goal.tasks[2].completionStatus)
            } header: {
                Text("What are the three tasks to achieve it?")
            }
        }
        .navigationTitle("FocusOn")
    }
}

struct GoalCreationView: View {
    @Binding var goal: Goal
    let placeholder: String
    @Binding var name: String
    @Binding var completionStatus: Bool

    var body: some View {
        HStack {
            TextField(placeholder, text: $name)
            Button(
                action: {
                    if (completionStatus) {
                        if !(goal.tasks[0].completionStatus &&
                             goal.tasks[1].completionStatus &&
                             goal.tasks[2].completionStatus) {
                            completionStatus = false
                        }
                    } else {
                        completionStatus = true
                        goal.tasks[0].completionStatus = true
                        goal.tasks[1].completionStatus = true
                        goal.tasks[2].completionStatus = true
                    }
                }) {
                    Image(systemName: (completionStatus ? "checkmark.circle.fill" : "circle"))
                        .foregroundColor(completionStatus ? Color("SuccessColor") : .black)
                }
        }
    }
}

struct TaskCreationView: View {
    @Binding var goal: Goal
    @Binding var task: Task
    let placeholder: String
    @Binding var name: String
    @Binding var completionStatus: Bool


    var body: some View {
        HStack {
            TextField(placeholder, text: $name)
            Button(
                action: {
                    completionStatus = (completionStatus ? false : true)
                    goal.completionStatus = (goal.tasks[0].completionStatus &&
                                             goal.tasks[1].completionStatus &&
                                             goal.tasks[2].completionStatus)
                }) {
                    Image(systemName: (completionStatus ? "checkmark.circle.fill" : "circle"))
                        .foregroundColor(completionStatus ? Color("SuccessColor") : .black)
                }
        }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}

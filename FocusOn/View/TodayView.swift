//
//  TodayView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 03/02/2022.
//

import SwiftUI
import CoreData

struct TodayView: View {
    //    @Environment(\.managedObjectContext) var moc: NSManagedObjectContext

    @StateObject private var viewModel = TodayViewModel()
    @State private var text = ""
    private var currentGoal = Goal(
        id: UUID(),
        name: "",
        createdAt: Date(),
        isCompleted: false,
        tasks: Set<Task>())
    //    .init(entity: NSEntityDescription, insertInto: NSManagedObjectContext?)

    var body: some View {
        Form {

            Section {
                HStack {
                    TextField("My goal is to ...", text: $text)
                    Button(
                        action: {
                            currentGoal.updateName(name: text)
                            viewModel.checkGoal(goal: currentGoal)
                        }) {
                            Image(systemName: (currentGoal.isCompleted ? "checkmark.circle.fill" : "circle"))
                                .foregroundColor(currentGoal.isCompleted ? Color("SuccessColor") : .black)
                        }
                }
            } header: {
                Text("What is your goal for today?")
            }

            Section {
                ForEach(Array(currentGoal.tasks!), id: \.self) { task in
                    HStack {
                        TextField("My task is to ...", text: $text)
                        Button(
                            action: {
                                task.changeCompletionStatus()
                                viewModel.checkTasks(goal: currentGoal)
                            }) {
                                Image(systemName: (task.isCompleted ? "checkmark.circle.fill" : "circle"))
                                    .foregroundColor(task.isCompleted ? Color("SuccessColor") : .black)
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

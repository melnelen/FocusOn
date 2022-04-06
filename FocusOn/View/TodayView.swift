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
    private var currentGoal = Goal()
//    .init(entity: NSEntityDescription, insertInto: NSManagedObjectContext?)

    var body: some View {
        Form {

            Section {
                HStack {
                    TextField("My goal is to ...", text: $text)
                    Button(
                        action: {
                            viewModel.dataManager.updateGoalName(entity: currentGoal, text: text)
                            viewModel.checkGoalCompletionStatus(entity: currentGoal)
                        }) {
                            Image(systemName: (currentGoal.completionStatus ? "checkmark.circle.fill" : "circle"))
                                .foregroundColor(currentGoal.completionStatus ? Color("SuccessColor") : .black)
                        }
                }
            } header: {
                Text("What is your goal for today?")
            }

            Section {
                ForEach(Array(currentGoal.tasks as! Set<Task>), id: \.self) { task in
                    HStack {
                        TextField("My task is to ...", text: $text)
                        Button(
                            action: {
                                task.completionStatus = (currentGoal.completionStatus ? false : true)
                                viewModel.checkAllTasksCompletionStatus(entity: currentGoal)
                            }) {
                                Image(systemName: (task.completionStatus ? "checkmark.circle.fill" : "circle"))
                                    .foregroundColor(task.completionStatus ? Color("SuccessColor") : .black)
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

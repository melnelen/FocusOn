//
//  TodayView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 03/02/2022.
//

import SwiftUI

struct TodayView: View {
    @State private var goal = ""
    @State private var task1 = ""
    @State private var task2 = ""
    @State private var task3 = ""
    @State private var goalCompleted = false
    @State private var task1Completed = false
    @State private var task2Completed = false
    @State private var task3Completed = false
    
    var body: some View {
        Form {

            Section {
                HStack {
                    TextField("My goal is to ...", text: $goal)
                    Button(action: { goalCompleted = (goalCompleted ? false : true)
                    }) {
                        Image(systemName: (goalCompleted ? "checkmark.circle.fill" : "circle"))
                            .foregroundColor(goalCompleted ? Color("SuccessColor") : .black)
                    }
                }
            } header: {
                Text("What is your goal for today?")
            }

            Section {
                HStack{
                    TextField("My first task is to ...", text: $task1)
                    Button(action: { task1Completed = (task1Completed ? false : true)
                    }) {
                        Image(systemName: (task1Completed ? "checkmark.circle.fill" : "circle"))
                            .foregroundColor(task1Completed ? Color("SuccessColor") : .black)
                    }
                }
                HStack{
                    TextField("My second task is to ...", text: $task2)
                    Button(action: { task2Completed = (task2Completed ? false : true)
                    }) {
                        Image(systemName: (task2Completed ? "checkmark.circle.fill" : "circle"))
                            .foregroundColor(task2Completed ? Color("SuccessColor") : .black)
                    }
                }
                HStack{
                    TextField("My third task is to ...", text: $task3)
                    Button(action: { task3Completed = (task3Completed ? false : true)
                    }) {
                        Image(systemName: (task3Completed ? "checkmark.circle.fill" : "circle"))
                            .foregroundColor(task3Completed ? Color("SuccessColor") : .black)
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

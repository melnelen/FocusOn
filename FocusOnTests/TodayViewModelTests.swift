//
//  TodayView-ViewModel-Tests.swift
//  FocusOnTests
//
//  Created by Alexandra Ivanova on 25/03/2022.
//

import XCTest
@testable import FocusOn

class TodayViewModelTests: XCTestCase {
    func test_TodayView_ViewModel_goal_addValues() {
        // Given
        let todayVM = TodayViewModel()
        // When
        todayVM.savedGoal.name = "Create FocusOn app"
        todayVM.savedGoal.createdAt = Date()
        todayVM.savedGoal.completionStatus = false
        // Then
        XCTAssert(todayVM.savedGoal.name == "Create FocusOn app", "Failed to add a goal name")
        XCTAssert(Calendar.current.startOfDay(for: todayVM.savedGoal.createdAt) == Calendar.current.startOfDay(for: Date()), "Failed to add a goal date")
        XCTAssert(todayVM.savedGoal.completionStatus == false, "Failed to add a goal completion status")
    }

    func test_TodayView_ViewModel_goal_addThreeTasks() {
        // Given
        let todayVM = TodayViewModel()
        // When
        todayVM.savedGoal.tasks[0] = Task(name: "Create a project using SwiftUI", completionStatus: true)
        todayVM.savedGoal.tasks[1] = Task(name: "Implement MVVM structure to the project", completionStatus: true)
        todayVM.savedGoal.tasks[2] = Task(name: "Add Unit and UI tests", completionStatus: false)
        // Then
        XCTAssert(todayVM.savedGoal.tasks[0].name == "Create a project using SwiftUI", "Failed to add first task name")
        XCTAssert(todayVM.savedGoal.tasks[0].completionStatus == true, "Failed to add first task completion status")
        XCTAssert(todayVM.savedGoal.tasks[1].name == "Implement MVVM structure to the project", "Failed to add second task name")
        XCTAssert(todayVM.savedGoal.tasks[1].completionStatus == true, "Failed to add second task completion status")
        XCTAssert(todayVM.savedGoal.tasks[2].name == "Add Unit and UI tests", "Failed to add second task name")
        XCTAssert(todayVM.savedGoal.tasks[2].completionStatus == false, "Failed to add third task completion status")
    }
}

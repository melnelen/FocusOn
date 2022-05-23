//
//  TodayView-ViewModel-Tests.swift
//  FocusOnTests
//
//  Created by Alexandra Ivanova on 25/03/2022.
//

import XCTest
@testable import FocusOn

class TodayViewModelTests: XCTestCase {
    private var sut: TodayViewModel!
    private var mockDataService: DataServiceProtocol!

    override func setUp() {
        super.setUp()
        mockDataService = MockDataService()
        sut = TodayViewModel(dataService: mockDataService)
    }

    override func tearDown() {
        sut = nil
        mockDataService = nil
        super.tearDown()
    }

    func test_TodayViewModel_addGoal() {
        // Given
        // When
        sut.addGoal(name: "Create FocusOn app")
        let goal = sut.fetchGoals().first!
        // Then
        XCTAssert(goal.name == "Create FocusOn app", "Failed to add a goal")
    }

    func test_TodayViewModel_updateGoal() {
        // Given
        sut.addGoal(name: "Create FocusOn app")
        let goal = sut.fetchGoals().first!
        // When
        sut.updateGoal(goal: goal, name: "Test FocusOn app", isCompleted: true)
        // Then
        XCTAssert(goal.name == "Test FocusOn app", "Failed to update a goal name")
        XCTAssert(goal.isCompleted == true, "Failed to update a goal completion status")
    }

    func test_TodayViewModel_updateTask() {
        // Given
        sut.addGoal(name: "Test FocusOn app")
        let goal = sut.fetchGoals().first!
        let task = Array(goal.tasks)[0]
        // When
        sut.updateTask(task: task, name: "Create unit tests", isCompleted: true)
        // Then
        XCTAssert(task.name == "Create unit tests", "Failed to update a task name")
        XCTAssert(task.isCompleted == true, "Failed to update a task completion status")
    }

    func test_TodayViewModel_checkGoalIsCompleted_True() {
        // Given
        sut.addGoal(name: "Complete FocusOn app")
        let goal = sut.fetchGoals().first!
        let task1 = Array(goal.tasks)[0]
        let task2 = Array(goal.tasks)[1]
        let task3 = Array(goal.tasks)[2]
        goal.isCompleted = true
        // When
        sut.checkGoalIsCompleted(goal: goal)
        // Then
        XCTAssert(goal.isCompleted == false, "Failed to change a goal completion status")
        XCTAssert(task1.isCompleted == false, "Failed to change a task completion status for a goal")
        XCTAssert(task2.isCompleted == false, "Failed to change a task completion status for a goal")
        XCTAssert(task3.isCompleted == false, "Failed to change a task completion status for a goal")
    }

    func test_TodayViewModel_checkGoalIsCompleted_False() {
        // Given
        sut.addGoal(name: "Complete FocusOn app")
        let goal = sut.fetchGoals().first!
        let task1 = Array(goal.tasks)[0]
        let task2 = Array(goal.tasks)[1]
        let task3 = Array(goal.tasks)[2]
        // When
        sut.checkGoalIsCompleted(goal: goal)
        // Then
        XCTAssert(goal.isCompleted == true, "Failed to change a goal completion status")
        XCTAssert(task1.isCompleted == true, "Failed to change a task completion status for a goal")
        XCTAssert(task2.isCompleted == true, "Failed to change a task completion status for a goal")
        XCTAssert(task3.isCompleted == true, "Failed to change a task completion status for a goal")
    }

    func test_TodayViewModel_checkTaskIsCompleted_TaskTrue_GoalFalse() {
        // Given
        let todayVM = TodayViewModel()
        sut.addGoal(name: "Complete FocusOn app")
        let goal = sut.fetchGoals().first!
        let task1 = Array(goal.tasks)[0]
        let task2 = Array(goal.tasks)[1]
        let task3 = Array(goal.tasks)[2]
        // When
        todayVM.checkTaskIsCompleted(goal: goal, task: task1)
        // Then
        XCTAssert(goal.isCompleted == false, "Failed to change a goal completion status when changing task status")
        XCTAssert(task1.isCompleted == true, "Failed to change a task completion status")
        XCTAssert(task2.isCompleted == false, "Failed to change a task completion status")
        XCTAssert(task3.isCompleted == false, "Failed to change a task completion status")
    }

    func test_TodayViewModel_checkTaskIsCompleted_TaskTrue_GoalTrue() {
        // Given
        sut.addGoal(name: "Complete FocusOn app")
        let goal = sut.fetchGoals().first!
        let task1 = Array(goal.tasks)[0]
        let task2 = Array(goal.tasks)[1]
        let task3 = Array(goal.tasks)[2]
        // When
        sut.checkTaskIsCompleted(goal: goal, task: task1)
        sut.checkTaskIsCompleted(goal: goal, task: task2)
        sut.checkTaskIsCompleted(goal: goal, task: task3)
        // Then
        XCTAssert(goal.isCompleted == true, "Failed to change a goal completion status when changing task status")
        XCTAssert(task1.isCompleted == true, "Failed to change a task completion status")
        XCTAssert(task2.isCompleted == true, "Failed to change a task completion status")
        XCTAssert(task3.isCompleted == true, "Failed to change a task completion status")
    }

    func test_TodayViewModel_checkTaskIsCompleted_TaskFalse_GoalFalse() {
        // Given
        sut.addGoal(name: "Complete FocusOn app")
        let goal = sut.fetchGoals().first!
        let task1 = Array(goal.tasks)[0]
        let task2 = Array(goal.tasks)[1]
        let task3 = Array(goal.tasks)[2]
        task1.isCompleted = true
        task2.isCompleted = true
        task3.isCompleted = true
        // When
        sut.checkTaskIsCompleted(goal: goal, task: task1)
        // Then
        XCTAssert(goal.isCompleted == false, "Failed to change a goal completion status when changing task status")
        XCTAssert(task1.isCompleted == false, "Failed to change a task completion status")
        XCTAssert(task2.isCompleted == true, "Failed to change a task completion status")
        XCTAssert(task3.isCompleted == true, "Failed to change a task completion status")
    }
}

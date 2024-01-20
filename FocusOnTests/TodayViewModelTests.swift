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
    
    func test_TodayViewModel_addGoal() throws {
        // Given
        // When
        try sut.addNewGoal(name: "Create FocusOn app")
        let goal = sut.allGoals!.last!
        // Then
        XCTAssert(goal.name == "Create FocusOn app", "Failed to add a goal")
        // Clean up
        try sut.deleteGoal(goal: goal)
    }
    
    func test_TodayViewModel_updateGoalName() throws {
        // Given
        try sut.addNewGoal(name: "Create FocusOn app")
        let goal = sut.allGoals!.last!
        // When
        try sut.updateGoal(goal: goal, name: "Test FocusOn app", date: goal.createdAt)
        // Then
        XCTAssert(goal.name == "Test FocusOn app", "Failed to update a goal name")
        // Clean up
        try sut.deleteGoal(goal: goal)
    }
    
    func test_TodayViewModel_updateTask() throws {
        // Given
        try sut.addNewGoal(name: "Test FocusOn app")
        let goal = sut.allGoals!.last!
        let task = Array(goal.tasks)[0]
        // When
        try sut.updateTask(goal: goal, task: task, name: "Create unit tests", isCompleted: true, index: 0)
        // Then
        XCTAssert(task.name == "Create unit tests", "Failed to update a task name")
        XCTAssert(task.isCompleted == true, "Failed to update a task completion status")
        // Clean up
        try sut.deleteGoal(goal: goal)
    }
    
    func test_TodayViewModel_checkGoalIsCompleted_True() throws {
        // Given
        try sut.addNewGoal(name: "Complete FocusOn app")
        let goal = sut.allGoals!.last!
        let task1 = Array(goal.tasks)[0]
        let task2 = Array(goal.tasks)[1]
        let task3 = Array(goal.tasks)[2]
        task1.isCompleted = true
        task2.isCompleted = true
        task3.isCompleted = true
        try sut.updateGoal(goal: goal, name: goal.name, date: goal.createdAt)
        // When
        try sut.checkGoalIsCompleted(goal: goal)
        // Then
        XCTAssert(goal.isCompleted == false, "Failed to change a goal completion status")
        XCTAssert(task1.isCompleted == false, "Failed to change a task completion status for a goal")
        XCTAssert(task2.isCompleted == false, "Failed to change a task completion status for a goal")
        XCTAssert(task3.isCompleted == false, "Failed to change a task completion status for a goal")
        // Clean up
        try sut.deleteGoal(goal: goal)
    }
    
    func test_TodayViewModel_checkGoalIsCompleted_False() throws {
        // Given
        try sut.addNewGoal(name: "Complete FocusOn app")
        let goal = sut.allGoals!.last!
        let task1 = Array(goal.tasks)[0]
        let task2 = Array(goal.tasks)[1]
        let task3 = Array(goal.tasks)[2]
        // When
        try sut.checkGoalIsCompleted(goal: goal)
        // Then
        XCTAssert(goal.isCompleted == true, "Failed to change a goal completion status")
        XCTAssert(task1.isCompleted == true, "Failed to change a task completion status for a goal")
        XCTAssert(task2.isCompleted == true, "Failed to change a task completion status for a goal")
        XCTAssert(task3.isCompleted == true, "Failed to change a task completion status for a goal")
        // Clean up
        try sut.deleteGoal(goal: goal)
    }
    
    func test_TodayViewModel_checkTaskIsCompleted_TaskTrue_GoalFalse() throws {
        // Given
        let todayVM = TodayViewModel()
        try sut.addNewGoal(name: "Complete FocusOn app")
        let goal = sut.allGoals!.last!
        let task1 = Array(goal.tasks)[0]
        let task2 = Array(goal.tasks)[1]
        let task3 = Array(goal.tasks)[2]
        // When
        try todayVM.checkTaskIsCompleted(goal: goal, task: task1)
        // Then
        XCTAssert(goal.isCompleted == false, "Failed to change a goal completion status when changing task status")
        XCTAssert(task1.isCompleted == true, "Failed to change a task completion status")
        XCTAssert(task2.isCompleted == false, "Failed to change a task completion status")
        XCTAssert(task3.isCompleted == false, "Failed to change a task completion status")
        // Clean up
        try sut.deleteGoal(goal: goal)
    }
    
    func test_TodayViewModel_checkTaskIsCompleted_TaskTrue_GoalTrue() throws {
        // Given
        try sut.addNewGoal(name: "Complete FocusOn app")
        let goal = sut.allGoals!.last!
        let task1 = Array(goal.tasks)[0]
        let task2 = Array(goal.tasks)[1]
        let task3 = Array(goal.tasks)[2]
        // When
        try sut.checkTaskIsCompleted(goal: goal, task: task1)
        try sut.checkTaskIsCompleted(goal: goal, task: task2)
        try sut.checkTaskIsCompleted(goal: goal, task: task3)
        // Then
        XCTAssert(goal.isCompleted == true, "Failed to change a goal completion status when changing task status")
        XCTAssert(task1.isCompleted == true, "Failed to change a task completion status")
        XCTAssert(task2.isCompleted == true, "Failed to change a task completion status")
        XCTAssert(task3.isCompleted == true, "Failed to change a task completion status")
        // Clean up
        try sut.deleteGoal(goal: goal)
    }
    
    func test_TodayViewModel_checkTaskIsCompleted_TaskFalse_GoalFalse() throws {
        // Given
        try sut.addNewGoal(name: "Complete FocusOn app")
        let goal = sut.allGoals!.last!
        let task1 = Array(goal.tasks)[0]
        let task2 = Array(goal.tasks)[1]
        let task3 = Array(goal.tasks)[2]
        task1.isCompleted = true
        task2.isCompleted = true
        task3.isCompleted = true
        // When
        try sut.checkTaskIsCompleted(goal: goal, task: task1)
        // Then
        XCTAssert(goal.isCompleted == false, "Failed to change a goal completion status when changing task status")
        XCTAssert(task1.isCompleted == false, "Failed to change a task completion status")
        XCTAssert(task2.isCompleted == true, "Failed to change a task completion status")
        XCTAssert(task3.isCompleted == true, "Failed to change a task completion status")
        // Clean up
        try sut.deleteGoal(goal: goal)
    }
}

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

    func test_TodayViewModel_addGoal_WithEmptyName() {
        // Given
        var error = "No error!"
        // When
        do {
            try sut.addGoal(name: "")
        } catch NameLengthError.empty {
            error = "The name is empty!"
        } catch NameLengthError.short {
            error = "The name is too short!"
        } catch {
            print("Something went wrong!")
        }
        // Then
        XCTAssert(error == "The name is empty!", "Could not catch the error for an empty name when adding a goal")
    }

    func test_TodayViewModel_addGoal_WithShortName() {
        // Given
        var error = "No error!"
        // When
        do {
            try sut.addGoal(name: "G")
        } catch NameLengthError.empty {
            error = "The name is empty!"
        } catch NameLengthError.short {
            error = "The name is too short!"
        } catch {
            print("Something went wrong!")
        }
        // Then
        XCTAssert(error == "The name is too short!", "Could not catch the error for a name that is too short when adding a goal")
    }

    func test_TodayViewModel_addGoal() throws {
        // Given
        // When
        try sut.addGoal(name: "Create FocusOn app")
        let goal = sut.fetchGoals()!.last!
        // Then
        XCTAssert(goal.name == "Create FocusOn app", "Failed to add a goal")
    }

    func test_TodayViewModel_updateGoal_WithEmptyName() {
        // Given
        var error = "No error!"
        do { try sut.addGoal(name: "Create FocusOn app") } catch { }
        let goal = sut.fetchGoals()!.last!
        // When
        do {
            try sut.updateGoal(goal: goal, name: "")
        } catch NameLengthError.empty {
            error = "The name is empty!"
        } catch NameLengthError.short {
            error = "The name is too short!"
        } catch {
            print("Something went wrong!")
        }
        // Then
        XCTAssert(error == "The name is empty!", "Could not catch the error for an empty name when updating a goal")
    }

    func test_TodayViewModel_updateGoal_WithShortName() throws {
        // Given
        var error = "No error!"
        try sut.addGoal(name: "Create FocusOn app")
        let goal = sut.fetchGoals()!.last!
        // When
        do {
            try sut.updateGoal(goal: goal, name: "UG")
        } catch NameLengthError.empty {
            error = "The name is empty!"
        } catch NameLengthError.short {
            error = "The name is too short!"
        } catch {
            print("Something went wrong!")
        }
        // Then
        XCTAssert(error == "The name is too short!", "Could not catch the error for a name that is too short when updating a goal")
    }

    func test_TodayViewModel_updateGoal() throws {
        // Given
        try sut.addGoal(name: "Create FocusOn app")
        let goal = sut.fetchGoals()!.last!
        // When
        try sut.updateGoal(goal: goal, name: "Test FocusOn app", isCompleted: true)
        // Then
        XCTAssert(goal.name == "Test FocusOn app", "Failed to update a goal name")
        XCTAssert(goal.isCompleted == true, "Failed to update a goal completion status")
    }

    func test_TodayViewModel_updateTask_WithEmptyName() throws {
        // Given
        var error = "No error!"
        try sut.addGoal(name: "Test FocusOn app")
        let goal = sut.fetchGoals()!.last!
        let task = Array(goal.tasks)[0]
        // When
        do {
            try sut.updateTask(task: task, name: "")
        } catch NameLengthError.empty {
            error = "The name is empty!"
        } catch NameLengthError.short {
            error = "The name is too short!"
        } catch {
            print("Something went wrong!")
        }
        // Then
        XCTAssert(error == "The name is empty!", "Could not catch the error for an empty name when updating a task")
    }

    func test_TodayViewModel_updateTask_WithShortName() throws {
        // Given
        var error = "No error!"
        try sut.addGoal(name: "Test FocusOn app")
        let goal = sut.fetchGoals()!.last!
        let task = Array(goal.tasks)[0]
        // When
        do {
            try sut.updateTask(task: task, name: "UT")
        } catch NameLengthError.empty {
            error = "The name is empty!"
        } catch NameLengthError.short {
            error = "The name is too short!"
        } catch {
            print("Something went wrong!")
        }
        // Then
        XCTAssert(error == "The name is too short!", "Could not catch the error for a name that is too short when updating a task")
    }

    func test_TodayViewModel_updateTask() throws {
        // Given
        try sut.addGoal(name: "Test FocusOn app")
        let goal = sut.fetchGoals()!.last!
        let task = Array(goal.tasks)[0]
        // When
        try sut.updateTask(task: task, name: "Create unit tests", isCompleted: true)
        // Then
        XCTAssert(task.name == "Create unit tests", "Failed to update a task name")
        XCTAssert(task.isCompleted == true, "Failed to update a task completion status")
    }

    func test_TodayViewModel_checkGoalIsCompleted_True() throws {
        // Given
        try sut.addGoal(name: "Complete FocusOn app")
        let goal = sut.fetchGoals()!.last!
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

    func test_TodayViewModel_checkGoalIsCompleted_False() throws {
        // Given
        try sut.addGoal(name: "Complete FocusOn app")
        let goal = sut.fetchGoals()!.last!
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

    func test_TodayViewModel_checkTaskIsCompleted_TaskTrue_GoalFalse() throws {
        // Given
        let todayVM = TodayViewModel()
        try sut.addGoal(name: "Complete FocusOn app")
        let goal = sut.fetchGoals()!.last!
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

    func test_TodayViewModel_checkTaskIsCompleted_TaskTrue_GoalTrue() throws {
        // Given
        try sut.addGoal(name: "Complete FocusOn app")
        let goal = sut.fetchGoals()!.last!
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

    func test_TodayViewModel_checkTaskIsCompleted_TaskFalse_GoalFalse() throws {
        // Given
        try sut.addGoal(name: "Complete FocusOn app")
        let goal = sut.fetchGoals()!.last!
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

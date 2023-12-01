//
//  HistoryViewModelTests.swift
//  FocusOnTests
//
//  Created by Alexandra Ivanova on 27/11/2023.
//

import XCTest
@testable import FocusOn

final class HistoryViewModelTests: XCTestCase {
    private var sut: HistoryViewModel!
    private var mockDataService: DataServiceProtocol!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockDataService = MockDataService()
        sut = HistoryViewModel(dataService: mockDataService)
    }

    override func tearDownWithError() throws {
        mockDataService = nil
        sut = nil
        try super.tearDownWithError()
    }

    func test_HistoryViewModel_FormattedGoalDate_withAValidGoalDate() {
        // Given
        let date = mockDataService.allGoals!.last!.createdAt
        let expectedFormattedDate = "13 Oct 2023"

        // When
        let formattedDate = sut.formattedGoalDate(from: date)

        // Then
        XCTAssertEqual(formattedDate, expectedFormattedDate, "Formatted date does not match the expected result.")
    }

    func test_HistoryViewModel_GoalsForMonth_NumberOfGoals_MonthWithData() {
        // Given
        let allGoals = mockDataService.allGoals!

        // When
        let result = sut.goalsForMonth(goals: allGoals, month: "October 2023")

        // Then
        XCTAssertEqual(result.count, 11, "Incorrect number of goals for the month.")
    }
    
    func test_HistoryViewModel_GoalsForMonth_NumberOfGoals_MonthWithNoData() {
        // Given
        let allGoals = mockDataService.allGoals!

        // When
        let result = sut.goalsForMonth(goals: allGoals, month: "January 2022")

        // Then
        XCTAssertEqual(result.count, 0, "Incorrect number of goals for the month.")
    }
    
    func test_HistoryViewModel_GoalsForMonth_GoalsSorting() {
        // Given
        let allGoals = mockDataService.allGoals!

        // When
        let result = sut.goalsForMonth(goals: allGoals, month: "October 2023")
        let firstGoal = result[0]
        let secondGoal = result[1]

        // Then
        XCTAssertEqual(firstGoal.name, "Test goal 0", "Incorrect sorting order or filtering.")
        XCTAssertEqual(secondGoal.name, "Test goal 2", "Incorrect sorting order or filtering.")
    }

    // Helper function to create a Date object with a specific month
    private func createDate(month: Int) -> Date {
        var components = DateComponents()
        components.year = 2022
        components.month = month
        components.day = 1
        return Calendar.current.date(from: components)!
    }
}

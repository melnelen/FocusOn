//
//  ProgressViewModelTests.swift
//  FocusOnTests
//
//  Created by Alexandra Ivanova on 05/08/2023.
//

import XCTest
import SwiftUICharts
@testable import FocusOn

class ProgressViewModelTests: XCTestCase {
    
    var viewModel: ProgressViewModel!
    
    override func setUpWithError() throws {
        viewModel = ProgressViewModel(dataService: MockDataService())
    }
    
    func testFillChartDataWithNilGoals() {
        // Given
        viewModel.allGoals = nil
        // When
        let chartData = viewModel.fillChartData()
        // Then
        XCTAssertNil(chartData)
    }
    
    func testFillChartDataWithEmptyGoals() {
        // Given
        viewModel.allGoals = []
        // When
        let chartData = viewModel.fillChartData()
        // Then
        XCTAssertNil(chartData)
    }
    
    func testFillChartDataWithGoals() {
        // Given
        let mockGoals = viewModel.allGoals!
        // When
        let chartData = viewModel.fillChartData()
        // Then
        XCTAssertNotNil(chartData)
        XCTAssertEqual(chartData?.count, mockGoals.count)
    }
    
    func testCalculateNumberOfCompletedTasks() {
        // Given
        let mockGoal = viewModel.allGoals![0]
        // When
        let numberOfCompletedTasks = viewModel.calculateNumberOfCompletedTasks(goal: mockGoal)
        // Then
        XCTAssertEqual(numberOfCompletedTasks, 3)
    }
    
    func testCalculateGoalProgress() {
        // Given
        let mockGoal = viewModel.allGoals![0]
        // When
        let legend = viewModel.calculateGoalProgress(goal: mockGoal)
        // Then
        XCTAssertEqual(legend, Legend(color: .green, label: "Success", order: 5))
    }
}

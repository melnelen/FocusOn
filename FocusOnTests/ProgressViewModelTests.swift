//
//  ProgressViewModelTests.swift
//  FocusOnTests
//
//  Created by Alexandra Ivanova on 05/08/2023.
//

import XCTest
import SwiftUI
import SwiftUICharts
@testable import FocusOn

class ProgressViewModelTests: XCTestCase {
    private var sut: ProgressViewModel!
    private var mockDataService: DataServiceProtocol!
    private var chunkedChartDataByWeek: [[DataPoint]]?
    private let calendar = Calendar.current
    private let firstWeekday = 4
    
    override func setUp() {
        super.setUp()
        mockDataService = MockDataService()
        sut = ProgressViewModel(dataService: mockDataService, calendar: Calendar.current)
    }
    
    func test_ProgressViewModel_FillChartData_WithNoGoals() {
        // Given
        sut.allGoals = nil
        // When
        let chartData = sut.fillChartData()
        // Then
        XCTAssertNil(chartData, "Chart data should be nil when there are no goals.")
    }
    
    func test_ProgressViewModel_FillChartData_WithEmptyGoals() {
        // Given
        sut.allGoals = []
        // When
        let chartData = sut.fillChartData()
        // Then
        XCTAssertNil(chartData, "Chart data should be empty when there is an empty list of goals.")
    }
    
    func test_ProgressViewModel_FillChartData_WithGoals() {
        // Given
        sut.allGoals = mockDataService.allGoals
        // When
        let chartData = sut.fillChartData()
        // Then
        XCTAssertNotNil(chartData, "Chart data should not be nil when there are goals.")
    }
    
    func test_ProgressViewModel_ChartBarHeight_ForNoGoal() {
        // Given
        sut.allGoals = mockDataService.allGoals
        // When
        let chartData = sut.fillChartData()
        let testDataPiont = chartData![3][3] // data point for an empty day
        let barHeight = testDataPiont.endValue
        // Then
        XCTAssertEqual(barHeight, 0.0, "Bar height should be 0.")
    }
    
    func test_ProgressViewModel_ChartBarHeight_ForFail() {
        // Given
        sut.allGoals = mockDataService.allGoals
        // When
        let chartData = sut.fillChartData()
        let testDataPiont = chartData![3][0] // data point for failed goal
        let barHeight = testDataPiont.endValue
        // Then
        XCTAssertEqual(barHeight, 1.0, "Bar height should be 1.")
    }
    
    func test_ProgressViewModel_ChartBarHeight_ForSmallProgress() {
        // Given
        sut.allGoals = mockDataService.allGoals
        // When
        let chartData = sut.fillChartData()
        let testDataPiont = chartData![3][1] // data point for small progress goal
        let barHeight = testDataPiont.endValue
        // Then
        XCTAssertEqual(barHeight, 2.0, "Bar height should be 2.")
    }
    
    func test_ProgressViewModel_ChartBarHeight_ForBigProgress() {
        // Given
        sut.allGoals = mockDataService.allGoals
        // When
        let chartData = sut.fillChartData()
        let testDataPiont = chartData![3][2] // data point for big progress goal
        let barHeight = testDataPiont.endValue
        // Then
        XCTAssertEqual(barHeight, 3.0, "Bar height should be 3.")
    }
    
    func test_ProgressViewModel_ChartBarHeight_ForSussess() {
        // Given
        sut.allGoals = mockDataService.allGoals
        // When
        let chartData = sut.fillChartData()
        let testDataPiont = chartData![3][4] // data point for last goal
        let barHeight = testDataPiont.endValue
        // Then
        XCTAssertEqual(barHeight, 4.0, "Bar height should be 4.")
    }
    
    func test_ProgressViewModel_ChartLabel() {
        // Given
        sut.allGoals = mockDataService.allGoals
        let mockGoal = sut.allGoals!.last! // last goal
        // When
        let chartData = sut.fillChartData()
        let testDataPiont = chartData![3][4] // data point for last goal
        let dayComponent = LocalizedStringKey(String(Calendar.current.component(.day, from: mockGoal.createdAt)))
        let label = testDataPiont.label.self
        // Then
        XCTAssertEqual(label, dayComponent, "Label should be the date of the last goal.")
    }
    
    func test_ProgressViewModel_ChartLabel_NoGoalDay() {
        // Given
        sut.allGoals = mockDataService.allGoals
        // When
        let chartData = sut.fillChartData()
        let testDataPiont = chartData![3][3] // data point for a day with no goal set up
        let noGoalDay = LocalizedStringKey("12")
        let label = testDataPiont.label.self
        // Then
        XCTAssertEqual(label, noGoalDay, "Label should be the date of the day with no goal.")
    }
    
    func test_ProgressViewModel_ChartLegend() {
        // Given
        sut.allGoals = mockDataService.allGoals
        // When
        let chartData = sut.fillChartData()
        let testDataPiont = chartData![3][4] // data point for last goal
        let legend = testDataPiont.legend
        // Then
        XCTAssertEqual(legend, Legend(color: Color("SuccessColor"), label: "Success", order: 5))
    }
    
    func test_ProgressViewModel_WeekStartsOnWednesday() {
        // Given
        var customCalendar = Calendar.current
        customCalendar.firstWeekday = 4 // Wednesday
        sut = ProgressViewModel(dataService: mockDataService, calendar: customCalendar)
        
        // When
        let chartData = sut.fillChartData()
        let testDataPiont = chartData![3][0] // data point for last goal
        let legend = testDataPiont.legend
        // Then
        XCTAssertEqual(legend, Legend(color: Color("AccentColor"), label: "Big Progress", order: 4))
    }
    
    override func tearDown() {
        sut = nil
        mockDataService = nil
        super.tearDown()
    }
}

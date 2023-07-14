//
//  ProgressViewModel.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 12/07/2023.
//

import Foundation
import SwiftUICharts

class ProgressViewModel: ObservableObject {
    @Published var allGoals: [Goal]?
    @Published var chartData: [DataPoint]?
    private let dataService: DataServiceProtocol

    init( dataService: DataServiceProtocol = MockDataService()) {
        self.dataService = dataService
        self.allGoals = dataService.allGoals
        self.chartData = dataService.chartData
    }

    func fetchGoals() -> [Goal]? {
        allGoals = dataService.fetchGoals()
        return allGoals
    }
}

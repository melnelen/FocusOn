//
//  HistoryView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 30/05/2022.
//

import Foundation

class HistoryViewModel: ObservableObject {
    @Published var allGoals: [Goal]?
    private let dataService: DataServiceProtocol

    init( dataService: DataServiceProtocol = MockDataService()) {
        self.dataService = dataService
    }

    func fetchGoals() -> [Goal]? {
        allGoals = dataService.fetchGoals()
        return allGoals
    }
}

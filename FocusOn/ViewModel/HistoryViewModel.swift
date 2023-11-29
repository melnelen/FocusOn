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
    
    init( dataService: DataServiceProtocol = DataService()) {
        self.dataService = dataService
        self.allGoals = dataService.allGoals
    }
    
    func fetchGoals() -> [Goal]? {
        allGoals = dataService.fetchGoals()
        return allGoals
    }
}

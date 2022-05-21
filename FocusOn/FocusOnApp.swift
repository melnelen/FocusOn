//
//  FocusOnApp.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 23/12/2021.
//

import SwiftUI

@main
struct FocusOnApp: App {
    let dataService = GoalDataService()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, dataService.container.viewContext)
        }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

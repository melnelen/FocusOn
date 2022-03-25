//
//  FocusOnApp.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 23/12/2021.
//

import SwiftUI

@main
struct FocusOnApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

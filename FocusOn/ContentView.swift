//
//  ContentView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 23/12/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State private var selection = 2

    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                HistoryView()
                    .tabItem {
                        Label("History", systemImage: "list.bullet")
                    }.tag(1)
                TodayView()
                    .tabItem {
                        Label("Today", systemImage: "circle.circle.fill")
                    }.tag(2)
                ProgressView()
                    .tabItem {
                        Label("Progress", systemImage: "chart.bar.xaxis")
                    }.tag(3)
            }
            .foregroundColor(.black)
            .accentColor(Color("SuccessColor"))
            .onAppear() {
                UITabBar.appearance().backgroundColor = UIColor(named: "AlternateColor")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

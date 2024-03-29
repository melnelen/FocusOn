//
//  ContentView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 23/12/2021.
//

import SwiftUI

struct MainView: View {
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
            .onAppear() {
                UITabBar.appearance().backgroundColor = UIColor(named: "AlternateColor")
                NotificationManager.shared.requestAuthorization()
            }
        }
    }
}

#Preview {
    MainView()
}


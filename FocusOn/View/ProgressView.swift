//
//  ProgressView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 06/02/2022.
//

import SwiftUI
import SwiftUICharts

struct ProgressView: View {
    @StateObject var viewModel = ProgressViewModel()
    
    @State private var chunkedChartDataByWeek: [[DataPoint]]?
    @State private var weeksNumbers: [Int]?
    @State private var tabViewSelection = 0
    
    var body: some View {
        NavigationView {
            VStack {
                if let allGoals = viewModel.allGoals, !allGoals.isEmpty {
                    TabView(selection: $tabViewSelection) {
                        ForEach(Array(zip(weeksNumbers ?? [], chunkedChartDataByWeek ?? [])), id: \.0) { weekNumber, chartDataForWeek in
                            LazyVStack {
                                Text("Week \(weekNumber)")
                                    .foregroundColor(.accentColor)
                                    .font(.headline)
                                    .padding()
                                
                                BarChartView(dataPoints: chartDataForWeek)
                                    .chartStyle(
                                        BarChartStyle(
                                            barMinHeight: 200,
                                            showAxis: false,
                                            showLegends: false
                                        )
                                    )
                                    .padding()
                            }
                            .padding()
                        }
                    }
                    .tabViewStyle(.page)
                    
                    LegendView()
                } else {
                    // No Goals Message
                    NoGoalsView()
                }
            }
            .navigationBarTitle("Progress")
            .onAppear {
                fetchGoals()
                fetchChartData()
                fetchWeeksNumbers()
            }
        }
    }
}

extension ProgressView {
    private func fetchGoals() {
        viewModel.allGoals = viewModel.fetchGoals()
    }
    
    private func fetchChartData() {
        chunkedChartDataByWeek = viewModel.fillChartData()
    }
    
    private func fetchWeeksNumbers() {
        weeksNumbers = viewModel.getWeeksNumbers(from: viewModel.allGoals ?? [])
        tabViewSelection = weeksNumbers?.last ?? 0
    }
}


#Preview {
    ProgressView()
}

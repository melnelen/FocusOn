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

private struct LegendView: View {
    var body: some View {
        Text("Legend:")
            .foregroundColor(.accentColor)
            .font(.headline)
            .padding()
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                HStack {
                    Circle()
                        .fill(Color("AlternateColor"))
                        .frame(width: 14, height: 14)
                        .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 2)
                        )
                    Text("No Goal")
                }
                HStack {
                    Circle()
                        .fill(Color("FailColor"))
                        .frame(width: 16, height: 16)
                    Text("Fail")
                }
                HStack {
                    Circle()
                        .fill(Color("ProgressColor"))
                        .frame(width: 16, height: 16)
                    Text("Small Progress")
                }
            }
            .padding()
            VStack(alignment: .leading) {
                HStack {
                    Circle()
                        .fill(Color("AccentColor"))
                        .frame(width: 16, height: 16)
                    Text("Big Progress")
                }
                HStack {
                    Circle()
                        .fill(Color("SuccessColor"))
                        .frame(width: 16, height: 16)
                    Text("Success")
                }
                
            }
            .padding()
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


struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
            .environmentObject(ProgressViewModel())
    }
}

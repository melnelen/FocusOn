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
    
    @State var allGoals: [Goal]?
    @State private var chunkedChartDataByWeek: [[DataPoint]]?
    @State private var weeksNumbers: [Int]?
    @State private var tabViewSelection = 0
    
    var body: some View {
        VStack {
            Text("Here is your progres")
                .foregroundColor(.accentColor)
                .font(.title)
            TabView(selection: $tabViewSelection) {
                ForEach(Array(zip(weeksNumbers ?? [], chunkedChartDataByWeek ?? [])), id: \.0) { weekNumber, chartDataForWeek in
                    VStack {
                        Text("Week \(weekNumber)")
                            .foregroundColor(.accentColor)
                            .font(.headline)
                            .padding(20)

                        BarChartView(dataPoints: chartDataForWeek)
                            .chartStyle(
                                BarChartStyle(
                                    barMinHeight: 100,
                                    showAxis: false,
                                    showLegends: false
                                )
                            )
                    }
                    .padding(20)
                }
            }
            .tabViewStyle(.page)
            
            LegendView()
        }
        .onAppear {
            fetchGoals()
            fetchChartData()
            fetchWeeksNumbers()
        }
    }
}

private struct LegendView: View {
    var body: some View {
        Text("Legend:")
            .foregroundColor(.accentColor)
            .font(.headline)
            .padding(20)
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                HStack {
                    Circle()
                        .fill(Color.white)
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
            .padding(10)
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
            .padding(10)
        }
    }
}

extension ProgressView {
    private func fetchGoals() {
        allGoals = viewModel.fetchGoals()
    }
    
    private func fetchChartData() {
        chunkedChartDataByWeek = viewModel.fillChartData()
    }
    
    private func fetchWeeksNumbers() {
        weeksNumbers = viewModel.getWeeksNumbers(from: allGoals ?? [])
        tabViewSelection = weeksNumbers?.last ?? 0
    }
}


struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
            .environmentObject(ProgressViewModel())
    }
}

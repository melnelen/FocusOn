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
    @State private var tabViewSelection = 0
    
    var body: some View {
        VStack {
            Text("Here is your progres")
                .foregroundColor(.accentColor)
                .font(.title)
            TabView(selection: $tabViewSelection) {
                ForEach(chunkedChartDataByWeek?.indices ?? 0..<0, id: \.self) { weekNumber in
                    if let chartDataForWeek = chunkedChartDataByWeek?[weekNumber] {
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
            }
            .onAppear { fetchChartData() }
            .tabViewStyle(.page)
            
            LegendView()
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
                        .fill(.red)
                        .frame(width: 16, height: 16)
                    Text("Fail")
                }
                HStack {
                    Circle()
                        .fill(.orange)
                        .frame(width: 16, height: 16)
                    Text("Small Progress")
                }
            }
            .padding(10)
            VStack(alignment: .leading) {
                HStack {
                    Circle()
                        .fill(.yellow)
                        .frame(width: 16, height: 16)
                    Text("Big Progress")
                }
                HStack {
                    Circle()
                        .fill(.green)
                        .frame(width: 16, height: 16)
                    Text("Success")
                }
                
            }
            .padding(10)
        }
    }
}

extension ProgressView {
    private func fetchChartData() {
        chunkedChartDataByWeek = viewModel.fillChartData()
        tabViewSelection = (chunkedChartDataByWeek?.count ?? 1) - 1
    }
}


struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
            .environmentObject(ProgressViewModel())
    }
}

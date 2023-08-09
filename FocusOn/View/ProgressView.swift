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
    
    @State private var chartData: [DataPoint]?
    
    var body: some View {
        VStack {
            Text("Here is your progres")
                .foregroundColor(.accentColor)
                .font(.largeTitle)
            ScrollView(.horizontal) {
                LazyHStack(spacing: 20) {
                    let chunkedChartData = chartData?.chunked(into: 7)
                    /*
                     ForEach(chartData) { data in
                        BarChartView(dataPoints: data ?? [])
                        .chartStyle(
                            BarChartStyle(
                                barMinHeight: 10,
                                showAxis: false,
                                showLegends: false
                            )
                        )
                     }
                     */
                    ForEach(0..<(chunkedChartData?.count)!, id: \.self) {
                        Text("Item \($0)")
                            .foregroundColor(.accentColor)
                            .font(.largeTitle)
                        HStack {
                            BarChartView(dataPoints: chartData ?? [])
                                .chartStyle(
                                    BarChartStyle(
                                        barMinHeight: 10,
                                        showAxis: false,
                                        showLegends: false
                                    )
                                )
                        }
                        .padding(20)
                    }
                }
            }
            HStack(spacing: 20) {
                BarChartView(dataPoints: chartData ?? [])
                    .chartStyle(
                        BarChartStyle(
                            barMinHeight: 10,
                            showAxis: false,
                            showLegends: true
                        )
                    )
            }
            .padding(20)
        }
        .onAppear { fetchChartData() }
    }
}

extension ProgressView {
    private func fetchChartData() {
        chartData = viewModel.fillChartData()
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
            .environmentObject(ProgressViewModel())
    }
}

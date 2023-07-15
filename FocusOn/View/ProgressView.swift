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
        HStack(spacing: 0) {
            BarChartView(dataPoints: chartData ?? [])
                .chartStyle(
                    BarChartStyle(
                        barMinHeight: 10,
                        showAxis: true,
                        showLegends: true
                    )
                )
        }
        .onAppear { fetchChartData() }
    }
}

extension ProgressView {
    private func fetchChartData() {
        chartData = viewModel.chartData
    }
}


struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
            .environmentObject(ProgressViewModel())
    }
}

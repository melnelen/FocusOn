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
            ScrollView(.horizontal, showsIndicators: false) {
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
                .flipsForRightToLeftLayoutDirection(true)
                .environment(\.layoutDirection, .rightToLeft)
            }
            .onAppear { fetchChartData() }
            .flipsForRightToLeftLayoutDirection(true)
            .environment(\.layoutDirection, .rightToLeft)
        }
    }
}

extension ProgressView {
    private func fetchChartData() {
        chartData = viewModel.fillChartData()
    }
}


struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
            .environmentObject(ProgressViewModel())
    }
}

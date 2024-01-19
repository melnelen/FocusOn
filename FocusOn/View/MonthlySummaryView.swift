//
//  MonthlySummaryView.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 19/01/2024.
//

import SwiftUI

struct MonthlySummaryView: View {
    @ObservedObject var viewModel: HistoryViewModel
    
    var month: String
    var summary: String
    
    var body: some View {
        LazyVStack {
            // Monthly Summary header
            Text("\(month)")
                .font(.title)
                .foregroundColor(Color.accentColor)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 10)
            // Monthly Summary details
            Text("\(summary)")
                .font(.headline)
                .foregroundColor(Color.accentColor)
                .padding(.vertical, 5)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    MonthlySummaryView(
        viewModel: HistoryView().viewModel,
        month: "January",
        summary: "2 out of 3 goals completed")
}

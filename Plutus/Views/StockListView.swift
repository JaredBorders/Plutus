//
//  StockListView.swift
//  Plutus
//
//  Created by Jared Borders on 1/17/21.
//

import SwiftUI

struct StockListView: View {
    @Binding var newComparison: ComparisonDetails
    @Binding var newTickerSelection: String?
    
    // PLEASE REFACTOR THIS (needs so much attention)
    
    var body: some View {
        ScrollView {
            LazyVStack {
                Button {
                    self.newComparison.stockTicker = "DOW"
                    self.newTickerSelection = nil
                } label: {
                    Text("Dow Jones Industrial Avg.")
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                Button {
                    self.newComparison.stockTicker = "S&P"
                    self.newTickerSelection = nil
                } label: {
                    Text("S&P 500")
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                Button {
                    self.newComparison.stockTicker = "NASDAQ"
                    self.newTickerSelection = nil
                } label: {
                    Text("Nasdaq")
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
            }
            .foregroundColor(.black)
            .font(.custom(Fonts.quicksandSemiBold, size: 16))
        }
    }
}

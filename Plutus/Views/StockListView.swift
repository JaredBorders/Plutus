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
    
    var body: some View {
        VStack {
            Text("Pick Stock to Compare")
                .font(.custom(Fonts.quicksandSemiBold, size: 16))
            Divider()
            ScrollView {
                LazyVStack {
                    ForEach(StockMarketIndex.allCases, id: \.self) { stock in
                        Button {
                            self.newComparison.stockTicker = stock.rawValue
                            self.newTickerSelection = nil
                        } label: {
                            Text(stock.rawValue)
                                .frame(width: 275, height: 10)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                        }
                    }
                }
                .foregroundColor(.black)
                .font(.custom(Fonts.quicksandSemiBold, size: 16))
            }
        }
    }
}

struct StockListView_Previews: PreviewProvider {
    static var previews: some View {
        StockListView(newComparison: .constant(ComparisonDetails()), newTickerSelection: .constant(""))
    }
}

//
//  WatchListCard.swift
//  Plutus
//
//  Created by Jared Borders on 1/16/21.
//

import SwiftUI

struct WatchListCard: View {
    
    var watchListItem: ComparisonValueModel

    @State var cryptoPrices: [Double] = []
    @State var comparedPriceDiff: [Double] = []
    @State var comparedPriceDiffPercentage: [Double] = []

    @State var stockPrices: [Double] = []
    @State var stockComparedPriceDiff: [Double] = []
    @State var stockComparedPriceDiffPercentage: [Double] = []
    
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                Text("📈 Elena's Graph") // GraphView will eventually go here @elena
                    .padding(80)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                HStack {
                    TickerView(name: watchListItem.cryptoName.rawValue, currentValue: "\(cryptoPrices.first ?? 0)", percentChange: "\(comparedPriceDiffPercentage.first ?? 0)", valueChange: "\(comparedPriceDiff.first ?? 0)", dateRange: watchListItem.timeRange)
                    TickerView(name: watchListItem.stockName.rawValue, currentValue: "\(stockPrices.first ?? 0)", percentChange: "\(stockComparedPriceDiffPercentage.first ?? 0)", valueChange: "\(stockComparedPriceDiff.first ?? 0)", dateRange: watchListItem.timeRange)
                }
            }
            .padding()
        }
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray, lineWidth: 1)
        )
        .onAppear(perform: {
            calculateChanges()
        })
    }
    private func calculateChanges() {
        if let cryptoP = watchListItem.crypto.prices?.compactMap({$0.last}) {
            cryptoPrices = cryptoP
            for i in 0..<(cryptoPrices.count-1) {
                let diff = cryptoPrices[i] - cryptoPrices[i+1]
                comparedPriceDiff.append(diff)
                let diffPercentage = diff / cryptoPrices[i]
                comparedPriceDiffPercentage.append(diffPercentage)
            }
        }

        watchListItem.stock.results.forEach({ (stockPrice) in
            stockPrices.append(stockPrice.o)
        })
        
        for i in 0..<(stockPrices.count - 1) {
            let diff = stockPrices[i] - stockPrices[i+1]
            stockComparedPriceDiff.append(diff)
            let diffPercentage = diff / stockPrices[i]
            stockComparedPriceDiffPercentage.append(diffPercentage)
        }
    }
}

struct WatchListCard_Previews: PreviewProvider {
    static var previews: some View {
        let data = ComparisonValueModel(timeRange: .Day, cryptoName: .AION, stockName: .AAPL, crypto: CryptoModel(prices: [[0.0]], marketCaps: [[0.0]], totalVolumes: [[0.0]]), stock: StockModel(ticker: "ticker", queryCount: 1, resultsCount: 7, adjusted: true, results: [StockResult(v: 0, vw: 0, o: 0, c: 0, h: 0, l: 0, t: 0)], status: "", requestID: "", count: 0))

        WatchListCard(watchListItem: data)
    }
}

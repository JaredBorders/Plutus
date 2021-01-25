//
//  WatchListCard.swift
//  Plutus
//
//  Created by Jared Borders on 1/16/21.
//

import SwiftUI

struct WatchListCard: View {
    var id = UUID()
    var isEditable: Bool // Component used in DetailsScreen. Should not be able to edit there.
    var edit: (() -> ())
//
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
                HStack {
                    Spacer()
                    Button {
                        edit() // Edit WatchListCard
                    } label: {
                        if isEditable {
                            Image(systemSymbol: .pencil)
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundColor(.gray)
                        }
                    }
                }
                StaticChart()
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

        WatchListCard(id: UUID(), isEditable: true, edit: {}, watchListItem: data)

//=======
//
//        let data = WathclistModel(crypto: .BTC, stock: .AEX, cryptoValue: "38500", cryptoDifference: "+10.5", stockValue: "345000", stockDifference: "-0.5")
//        let analysisModel = AnalysisModel(timeRange: .Day, watchlist: data)
//
//        WatchListCard(id: UUID(), isEditable: true, edit: {}, cryptoTicker: "BTC", stockTicker: "NASDAQ", watchListItem: analysisModel)
//>>>>>>> main
    }
}

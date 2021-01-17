//
//  WatchListCard.swift
//  Plutus
//
//  Created by Jared Borders on 1/16/21.
//

import SwiftUI

struct WatchListCard: View {
    
    var watchListItem: AnalysisModel
    
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
                    TickerView(name: watchListItem.watchlist.crypto.rawValue, currentValue: watchListItem.watchlist.cryptoValue, percentChange: watchListItem.watchlist.cryptoDifference, valueChange: "123", dateRange: watchListItem.timeRange)
                    TickerView(name: watchListItem.watchlist.stock.rawValue, currentValue: watchListItem.watchlist.stockValue, percentChange: watchListItem.watchlist.stockDifference, valueChange: "123", dateRange: watchListItem.timeRange)
                }
            }
            .padding()
        }
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}

struct WatchListCard_Previews: PreviewProvider {
    static var previews: some View {
        let data = WathclistModel(crypto: .BTC, stock: .AEX, cryptoValue: "38500", cryptoDifference: "+10.5", stockValue: "345000", stockDifference: "-0.5")
        let analysisModel = AnalysisModel(timeRange: .Day, watchlist: data)

        WatchListCard(watchListItem: analysisModel)
    }
}

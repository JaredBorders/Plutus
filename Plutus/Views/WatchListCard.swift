//
//  WatchListCard.swift
//  Plutus
//
//  Created by Jared Borders on 1/16/21.
//

import SwiftUI

struct WatchListCard: View, Identifiable {
    var id = UUID()
    var isEditable: Bool // Component used in DetailsScreen. Should not be able to edit there.
    var edit: (() -> ())
    
    var cryptoTicker: String
    var stockTicker: String

    var watchListItem: AnalysisModel
    
    var cryptoDifferece: Float {
        let value = watchListItem.watchlist.cryptoValue
        let diff = watchListItem.watchlist.cryptoDifference
        if let value = Float(value), let diff = Float(diff) {
            return value * (diff / 100)
        } else {
            return 0.0
        }
    }
    
    var stockDifferece: Float {
        let value = watchListItem.watchlist.stockValue
        let diff = watchListItem.watchlist.stockDifference
        if let value = Float(value), let diff = Float(diff) {
            return value * (diff / 100)
        } else {
            return 0.0
        }
    }
    
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
                Text("📈 Elena's Graph") // GraphView will eventually go here @elena
                    .padding(100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                HStack {

                    TickerView(name: watchListItem.watchlist.crypto.rawValue, currentValue: watchListItem.watchlist.cryptoValue, percentChange: watchListItem.watchlist.cryptoDifference, valueChange: "\(cryptoDifferece)", dateRange: watchListItem.timeRange)
                    TickerView(name: watchListItem.watchlist.stock.rawValue, currentValue: watchListItem.watchlist.stockValue, percentChange: watchListItem.watchlist.stockDifference, valueChange: "\(stockDifferece)", dateRange: watchListItem.timeRange)
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

        WatchListCard(id: UUID(), isEditable: true, edit: {}, cryptoTicker: "BTC", stockTicker: "NASDAQ", watchListItem: analysisModel)
    }
}

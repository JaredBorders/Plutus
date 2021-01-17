//
//  WatchListCard.swift
//  Plutus
//
//  Created by Jared Borders on 1/16/21.
//

import SwiftUI

struct WatchListCard: View {
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
                    TickerView(name: "BTC", currentValue: 40000, percentChange: 10, valueChange: 4000, dateRange: DateRanges.Day)
                    TickerView(name: "DOW", currentValue: 30814.26, percentChange: -0.57, valueChange: -177.26, dateRange: DateRanges.Day)
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
        WatchListCard()
    }
}

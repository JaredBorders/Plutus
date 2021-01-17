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
                    TickerView(name: cryptoTicker, currentValue: 40000, percentChange: 10, valueChange: 4000, dateRange: DateRanges.Day)
                    TickerView(name: stockTicker, currentValue: 30814.26, percentChange: -0.57, valueChange: -177.26, dateRange: DateRanges.Day)
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
        WatchListCard(isEditable: true, edit: {}, cryptoTicker: "BTC", stockTicker: "DOW")
    }
}

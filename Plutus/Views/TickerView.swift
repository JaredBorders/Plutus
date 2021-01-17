//
//  TickerView.swift
//  Plutus
//
//  Created by Jared Borders on 1/16/21.
//

import SwiftUI

struct TickerView: View {
    var name: String
    var currentValue: Float
    var percentChange: Float
    var valueChange: Float
    var dateRange: DateRanges
    
    // Float -> String
    private var currentValueStr: String { NSString(format: "%.2f", currentValue) as String }
    private var percentChangeStr: String { NSString(format: "%.2f", abs(percentChange)) as String }
    private var valueChangeStr: String { NSString(format: "%.2f", abs(valueChange)) as String }
    
    var postiveChange: Bool {
        percentChange > 0 ? true : false
    }
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                (postiveChange ? Image(systemSymbol: .arrowUpForward) : Image(systemSymbol: .arrowDownRight))
                    .foregroundColor(postiveChange ? .green : .red)
                Text(name)
                    .font(.custom(Fonts.quicksandSemiBold, size: 16))
            }
            Text("\(postiveChange ? "+" : "-" )$\(valueChangeStr) (\(postiveChange ? "+" : "-" )\(percentChangeStr)%)")
                .font(.custom(Fonts.quicksandSemiBold, size: 16))
                .foregroundColor(postiveChange ? .green : .red)
            Text("$\(currentValueStr)")
                .font(.custom(Fonts.quicksandLight, size: 16))
        }
        .padding(.vertical)
    }
}

struct TickerView_Previews: PreviewProvider {
    static var previews: some View {
        TickerView(name: "DOW", currentValue: 30814.26, percentChange: -0.57, valueChange: -177.26, dateRange: DateRanges.Day)
    }
}

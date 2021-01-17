//
//  TickerView.swift
//  Plutus
//
//  Created by Jared Borders on 1/16/21.
//

import SwiftUI

struct TickerView: View {
    var name: String
    var currentValue: String
    var percentChange: String
    var valueChange: String
    var dateRange: DateRanges
    
    // Float -> String
    private var currentValueStr: String {
        if let cv = Float(currentValue) {
            return NSString(format: "%.2f", cv) as String } else {
                return currentValue
            }
    }
    
    private var percentChangeStr: String {
        if let pc = Float(percentChange) {
            return NSString(format: "%.2f", abs(pc)) as String }
        else {
            return percentChange
        }
    }
    
    private var valueChangeStr: String {
        if let vc = Float(valueChange) {
            return NSString(format: "%.2f", abs(vc)) as String }
        else {
            return valueChange
        }
    }
    
    var postiveChange: Bool {
        if let pc = Float(percentChange) {
            return pc > 0 ? true : false
        } else {
            return false
        }
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
        TickerView(name: "DOW", currentValue: "30814.26", percentChange: "-0.57", valueChange: "-177.26", dateRange: DateRanges.Day)
    }
}

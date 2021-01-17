//
//  ComparsionCardView.swift
//  Plutus
//
//  Created by Jared Borders on 1/16/21.
//

import SwiftUI

struct ComparsionCardView: View {
    var name: String
    var currentValue: Float
    var percentChange: Float
    var valueChange: Float
    var dateRange: DateRanges
    var isSelected: Bool
    
    // Float -> String
    private var currentValueStr: String { NSString(format: "%.2f", currentValue) as String }
    private var percentChangeStr: String { NSString(format: "%.2f", abs(percentChange)) as String }
    private var valueChangeStr: String { NSString(format: "%.2f", abs(valueChange)) as String }
    
    var postiveChange: Bool {
        percentChange > 0 ? true : false
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            (isSelected ? Image(systemSymbol: .pinFill) : Image(systemSymbol: .pin))
                .padding([.top, .leading]).padding(.bottom, -25)
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        (postiveChange ? Image(systemSymbol: .arrowDownRight) : Image(systemSymbol: .arrowUpForward))
                            .foregroundColor(postiveChange ? .green : .red)
                        Text(name)
                            .font(.custom(Fonts.quicksandSemiBold, size: 18))
                    }
                    Text("$\(currentValueStr)")
                        .font(.custom(Fonts.quicksandLight, size: 18))
                }
                .padding(.vertical)
                Spacer()
                VStack(alignment: .center) {
                    Text(dateRange.rawValue)
                        .font(.custom(Fonts.quicksandSemiBold, size: 18))
                    Text("%\(percentChangeStr)")
                        .font(.custom(Fonts.quicksandSemiBold, size: 18))
                        .foregroundColor(postiveChange ? .green : .red)
                    Text("\(postiveChange ? "+" : "-")\(valueChangeStr)")
                        .font(.custom(Fonts.quicksandSemiBold, size: 18))
                        .foregroundColor(postiveChange ? .green : .red)
                }
                .padding(.vertical)
            }
            .padding(.horizontal)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}

struct ComparsionCardView_Previews: PreviewProvider {
    static var previews: some View {
        ComparsionCardView(name: "BTC", currentValue: 40000, percentChange: 10, valueChange: 4000, dateRange: DateRanges.Day, isSelected: false)
    }
}



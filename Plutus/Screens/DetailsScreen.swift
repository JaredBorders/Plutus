//
//  SwiftUIView.swift
//  Plutus
//
//  Created by Jared Borders on 1/16/21.
//

import SwiftUI

struct DetailsScreen: View {
    // No state varibales yet. This all just uses moch data
    
    var body: some View {
        VStack(spacing: 0) {
            DateRangePickerView()
            Divider()
            ScrollView { // eventually this will be a ForEach
                WatchListCard()
                    .padding(.top)
                Divider()
                ComparsionCardView(name: "BTC",
                                   currentValue: 44000,
                                   percentChange: 10,
                                   valueChange: 4000,
                                   dateRange: DateRanges.Day,
                                   isSelected: true)
                    .padding(.vertical, 6)
                    .padding(.horizontal)
                ComparsionCardView(name: "DOW",
                                   currentValue: 30814.26,
                                   percentChange: -0.57,
                                   valueChange: -177.26,
                                   dateRange: DateRanges.Day,
                                   isSelected: true)
                    .padding(.vertical, 6)
                    .padding(.horizontal)
                ComparsionCardView(name: "ETH",
                                   currentValue: 1400,
                                   percentChange: -8.3,
                                   valueChange: -113,
                                   dateRange: DateRanges.Day,
                                   isSelected: false)
                    .padding(.vertical, 6)
                    .padding(.horizontal)
                ComparsionCardView(name: "S&P 500",
                                   currentValue: 3768.25,
                                   percentChange: -0.72,
                                   valueChange: 27.29,
                                   dateRange: DateRanges.Day,
                                   isSelected: false)
                    .padding(.vertical, 6)
                    .padding(.horizontal)
            }
        }
        .navigationBarTitle("Add Comparisons", displayMode: .inline)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct DetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailsScreen()
    }
}

//
//  SwiftUIView.swift
//  Plutus
//
//  Created by Jared Borders on 1/16/21.
//

import SwiftUI

struct DetailsScreen: View {
    @State private var dictOfComparisons = [ComparisonDetails(cryptoTicker: "BTC", stockTicker: "DOW")]
    
    var body: some View {
        VStack(spacing: 0) {
            DateRangePickerView()
            Divider()
            ScrollView { // eventually this will be a ForEach
                WatchListCard(isEditable: false,
                              edit: {},
                              cryptoTicker: $dictOfComparisons[0].cryptoTicker,
                              stockTicker: $dictOfComparisons[0].stockTicker)
                    .padding([.top, .horizontal])
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
            }
        }
        .navigationBarTitle("Add Comparisons", displayMode: .inline)
    }
}

struct DetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailsScreen()
    }
}

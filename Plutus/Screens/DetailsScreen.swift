//
//  SwiftUIView.swift
//  Plutus
//
//  Created by Jared Borders on 1/16/21.
//

import SwiftUI

struct DetailsScreen: View {
    @State private var dictOfComparisons = [ComparisonDetails(cryptoTicker: "BTC", stockTicker: "DOW")]
    @ObservedObject var store = ChartStore()

    // No state varibales yet. This all just uses moch data
    var watchListItem: AnalysisModel
    
    var body: some View {
        VStack(spacing: 0) {
            DateRangePickerView()
            Divider()
            ScrollView { // eventually this will be a ForEach
//                WatchListCard(isEditable: false,
//                              edit: {},
//                              cryptoTicker: dictOfComparisons[0].cryptoTicker,
//                              stockTicker: dictOfComparisons[0].stockTicker)
//                    .padding([.top, .horizontal])
//                Divider()
//                ComparsionCardView(name: "BTC",
//                                   currentValue: 44000,
//                                   percentChange: 10,
//                                   valueChange: 4000,
//                                   dateRange: DateRanges.Day,
//                                   isSelected: true)
                LazyVStack {
                    WatchListCard(id: UUID(), isEditable: false, edit: {}, cryptoTicker: "BTC", stockTicker: "NASDAQ", watchListItem: watchListItem)
                        .padding(.top)
                    Divider()
                    ComparsionCardView(
                        name: "BTC",
                        currentValue: 44000,
                        percentChange: 10,
                        valueChange: 4000,
                        dateRange: DateRanges.Day,
                        isSelected: true
                    )
//                    .padding(.vertical, 6)
//                    .padding(.horizontal)
//                    ComparsionCardView(
//                        name: "DOW",
//                        currentValue: 30814.26,
//                        percentChange: -0.57,
//                        valueChange: -177.26,
//                        dateRange: DateRanges.Day,
//                        isSelected: true
//                    )
//                    .padding(.vertical, 6)
//                    .padding(.horizontal)
                    ComparsionCardView(
                        name: "ETH",
                        currentValue: 1400,
                        percentChange: -8.3,
                        valueChange: -113,
                        dateRange: DateRanges.Day,
                        isSelected: false
                    )
                    .padding(.vertical, 6)
                    .padding(.horizontal)
                    ComparsionCardView(
                        name: "S&P 500",
                        currentValue: 3768.25,
                        percentChange: -0.72,
                        valueChange: 27.29,
                        dateRange: DateRanges.Day,
                        isSelected: false
                    )
                    .padding(.vertical, 6)
                    .padding(.horizontal)
                }
                //
            }
        }
        .navigationBarTitle("Add Comparisons", displayMode: .inline)
        
    }
}

struct DetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        let watchList = WathclistModel(crypto: .BTC, stock: .AEX, cryptoValue: "38500", cryptoDifference: "+10.5", stockValue: "345000", stockDifference: "-0.5")
        let analysisModel = AnalysisModel(timeRange: .Day, watchlist: watchList)

        DetailsScreen(watchListItem: analysisModel)
    }
}

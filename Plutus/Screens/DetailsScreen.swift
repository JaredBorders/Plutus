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
        NavigationView {
            VStack {
                DateRangePickerView()
                Divider()
                Text("📈") // GraphView will eventually go here @elena
                    .padding()
                Divider()
                ScrollView {
                    ComparsionCardView(name: "BTC",
                                       currentValue: 44000,
                                       percentChange: 10,
                                       valueChange: 4000,
                                       dateRange: DateRanges.Day,
                                       isSelected: true)
                    ComparsionCardView(name: "ETH",
                                       currentValue: 1400,
                                       percentChange: -8.3,
                                       valueChange: -113,
                                       dateRange: DateRanges.Day,
                                       isSelected: false)
                    ComparsionCardView(name: "S&P 500",
                                       currentValue: 3768.25,
                                       percentChange: -0.72,
                                       valueChange: 27.29,
                                       dateRange: DateRanges.Day,
                                       isSelected: false)
                    Spacer()
                }
            }
            .navigationTitle("Add Comparisons")
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsScreen()
    }
}

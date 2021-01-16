//
//  SwiftUIView.swift
//  Plutus
//
//  Created by Jared Borders on 1/16/21.
//

import SwiftUI

struct DetailsScreen: View {
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    DateRangePickerView()
                    ComparsionCardView()
                    Text("ComparisonChartView")
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

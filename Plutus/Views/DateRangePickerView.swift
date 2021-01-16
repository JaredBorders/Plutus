//
//  DateRangePickerView.swift
//  Plutus
//
//  Created by Jared Borders on 1/16/21.
//

import SwiftUI
import SFSafeSymbols

struct DateRangePickerView: View {
    @State private var selectedDateRange = DateRanges.Day
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text("Select Range")
                    .font(.custom(Fonts.quicksandSemiBold, size: 18))
                Image(systemSymbol: .gear)
            }
            Picker("Date Range", selection: $selectedDateRange) {
                ForEach(DateRanges.allCases) { range in
                    Text(range.rawValue)
                }
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
}

struct DateRangePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DateRangePickerView()
    }
}

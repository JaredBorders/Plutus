//
//  AddComparisonScreen.swift
//  Plutus
//
//  Created by Jared Borders on 1/17/21.
//

import SwiftUI

struct AddComparisonScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var isShowingDetailsScreen: Bool
    @Binding var listOfComparisons: [ComparisonDetails]
    @State private var newComparison: ComparisonDetails = ComparisonDetails()
    @State private var newTickerSelection: String? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            DateRangePickerView()
            Divider()
            if !newComparison.stockTicker.isEmpty && !newComparison.cryptoTicker.isEmpty {
                StaticChart()
            } else {
                Text("N/a") // GraphView will eventually go here @elena
                    .padding(100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
            HStack {
                NavigationLink(
                    destination: CryptoListView(newComparison: $newComparison, newTickerSelection: $newTickerSelection),
                    tag: "CRYPTO",
                    selection: $newTickerSelection) {}
                NavigationLink(
                    destination: StockListView(newComparison: $newComparison, newTickerSelection: $newTickerSelection),
                    tag: "STOCK",
                    selection: $newTickerSelection) {}
                
                if newComparison.cryptoTicker == "" {
                    Button {
                        self.newTickerSelection = "CRYPTO"
                    } label: {
                        AddTickerSubView(type: "Crypto")
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding()
                } else {
                    TickerView(name: newComparison.cryptoTicker, currentValue: "40000", percentChange: "10", valueChange: "4000", dateRange: DateRanges.Day)
                }
                
                if newComparison.stockTicker == "" {
                    Button {
                        self.newTickerSelection = "STOCK"
                    } label: {
                        AddTickerSubView(type: "Stock")
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding()
                } else {
                    TickerView(name: newComparison.stockTicker, currentValue: "30814.26", percentChange: "-0.57", valueChange: "-177.26", dateRange: DateRanges.Day)
                }
            }
            Spacer()
        }
        .padding()
        .navigationBarTitle("Add Comparisons", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if newComparison.cryptoTicker != "" && newComparison.stockTicker != "" {
                        listOfComparisons.append(newComparison)
                    } else {
                        newComparison = ComparisonDetails()
                    }
                    self.isShowingDetailsScreen = false // Is this necessary? I am so tired idc to check..
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Done")
                        .foregroundColor(.black)
                }
            }
        }
    }
}

struct AddTickerSubView: View {
    var type: String
    var body: some View {
        VStack {
            Image(systemSymbol: .plusCircle)
                .resizable()
                .frame(width: 30, height: 30)
            Text("Add \(type)")
                .font(.custom(Fonts.quicksandSemiBold, size: 16))
                .frame(width: 100, height: 25)
        }
        .foregroundColor(.gray)
    }
}

struct AddComparisonScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddComparisonScreen(isShowingDetailsScreen: .constant(true), listOfComparisons: .constant([ComparisonDetails(cryptoTicker: "BTC", stockTicker: "DOW")]))
    }
}

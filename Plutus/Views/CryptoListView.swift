//
//  CryptoListView.swift
//  Plutus
//
//  Created by Jared Borders on 1/17/21.
//

import SwiftUI

struct CryptoListView: View {
    @Binding var newComparison: ComparisonDetails
    @Binding var newTickerSelection: String?
    
    // PLEASE REFACTOR THIS (needs so much attention)
    
    var body: some View {
        ScrollView {
            LazyVStack {
                Button {
                    self.newComparison.cryptoTicker = "BTC"
                    self.newTickerSelection = nil
                } label: {
                    Text("Bitcoin")
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                Button {
                    self.newComparison.cryptoTicker = "DOGE"
                    self.newTickerSelection = nil
                } label: {
                    Text("Dogecoin")
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                Button {
                    self.newComparison.cryptoTicker = "ETH"
                    self.newTickerSelection = nil
                } label: {
                    Text("Etherium")
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
            }
            .foregroundColor(.black)
            .font(.custom(Fonts.quicksandSemiBold, size: 16))
        }
    }
}

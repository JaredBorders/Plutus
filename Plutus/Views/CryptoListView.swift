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
    
    var body: some View {
        VStack {
            Text("Pick Cryptocurrency to Compare")
                .font(.custom(Fonts.quicksandSemiBold, size: 16))
            Divider()
            ScrollView {
                LazyVStack {
                    ForEach(DigitalCurrency.allCases, id: \.self) { crypto in
                        Button {
                            self.newComparison.cryptoTicker = crypto.rawValue
                            self.newTickerSelection = nil
                        } label: {
                            Text(crypto.rawValue)
                                .frame(width: 275, height: 10)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                        }
                    }
                }
                .foregroundColor(.black)
                .font(.custom(Fonts.quicksandSemiBold, size: 16))
            }
        }
    }
}

struct CryptoListView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoListView(newComparison: .constant(ComparisonDetails()), newTickerSelection: .constant(""))
    }
}

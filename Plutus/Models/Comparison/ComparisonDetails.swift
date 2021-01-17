//
//  ComparisonDetails.swift
//  Plutus
//
//  Created by Jared Borders on 1/17/21.
//

import Foundation

class ComparisonDetails: Identifiable {
    var id = UUID()
    var cryptoTicker: String
    var stockTicker: String
    
    init(cryptoTicker: String, stockTicker: String) {
        self.cryptoTicker = cryptoTicker
        self.stockTicker = stockTicker
    }
}

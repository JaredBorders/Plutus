//
//  constants.swift
//  Plutus
//
//  Created by Geraldine Turcios on 1/16/21.
//

import Foundation

enum Fonts {
    static let quicksandBold = "Quicksand-Bold"
    static let quicksandMedium = "Quicksand-Medium"
    static let quicksandRegular = "Quicksand-Regular"
    static let quicksandSemiBold = "Quicksand-SemiBold"
    static let quicksandLight = "Quicksand-Light"
}

enum DateRanges: String, CaseIterable, Identifiable, Codable {
    case Day
    case Week
    case Month
    case Year
    
    var id: String { self.rawValue }
}

struct DefaultComparisons {
    static let comparison : [FavoriteComparison] = [
//        FavoriteComparison(crypto: .BTC, stock: .IBM, timeRange: .Day),
//        FavoriteComparison(crypto: .BTC, stock: .AAPL, timeRange: .Day),
        FavoriteComparison(crypto: .ETH, stock: .ARKG, timeRange: .Day),
//        FavoriteComparison(crypto: .ETC, stock: .UVXY, timeRange: .Day),
        FavoriteComparison(crypto: .XRP, stock: .VXX, timeRange: .Day),
//        FavoriteComparison(crypto: .XRP, stock: .AAPL, timeRange: .Day),
//        FavoriteComparison(crypto: .AION, stock: .ARKG, timeRange: .Day),
//        FavoriteComparison(crypto: .AION, stock: .VXX, timeRange: .Day),
//        FavoriteComparison(crypto: .ZCC, stock: .AAPL, timeRange: .Day),
//        FavoriteComparison(crypto: .ZCC, stock: .IBM, timeRange: .Day)
    ]
}

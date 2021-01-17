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

enum DateRanges: String, CaseIterable, Identifiable {
    case Day
    case Week
    case Month
    case Year
    
    var id: String { self.rawValue }
}

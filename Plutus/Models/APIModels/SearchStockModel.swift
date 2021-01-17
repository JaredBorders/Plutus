//
//  SearchStockModel.swift
//
//  Created by Musa Kokcen on 17.01.2021.
//

import Foundation

struct SearchStockModel: Codable {
    let bestMatches: [BestMatch]
}

struct BestMatch: Codable {
    let symbol, name, type, region: String
    let marketOpen, marketClose, timezone, currency: String
    let matchScore: String

    enum CodingKeys: String, CodingKey {
        case symbol = "1. symbol"
        case name = "2. name"
        case type = "3. type"
        case region = "4. region"
        case marketOpen = "5. marketOpen"
        case marketClose = "6. marketClose"
        case timezone = "7. timezone"
        case currency = "8. currency"
        case matchScore = "9. matchScore"
    }
}

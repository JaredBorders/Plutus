//
//  CryptoModel.swift
//  Plutus
//
//  Created by Musa Kokcen on 23.01.2021.
//

import Foundation

enum CryptoDataRange {
    case daily, weekly, monthly
    
    var strigValue: String {
        switch self {
        case .daily:
            return "daily"
        case .weekly:
            return "weekly"
        case .monthly:
            return "monthly"
        }
    }
}

struct CryptoQueryModel {
    let interval: CryptoDataRange
    let numberOfData: Int
    let symbol: String
}

struct CryptoModel: Codable {
    let prices, marketCaps, totalVolumes: [[Double]]?

    enum CodingKeys: String, CodingKey {
        case prices
        case marketCaps = "market_caps"
        case totalVolumes = "total_volumes"
    }
}

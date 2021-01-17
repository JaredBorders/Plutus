//
//  WeeklyAdjustedStockModel.swift
//
//  Created by Musa Kokcen on 17.01.2021.
//

import Foundation
struct WeeklyAdjustedStockModel: Codable {
    let metaData: WeeklyMetaData
    let weeklyAdjustedTimeSeries: [String: WeeklyAdjustedTimeSery]

    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case weeklyAdjustedTimeSeries = "Weekly Adjusted Time Series"
    }
}

struct WeeklyMetaData: Codable {
    let information, symbol, lastRefreshed, timeZone: String

    enum CodingKeys: String, CodingKey {
        case information = "1. Information"
        case symbol = "2. Symbol"
        case lastRefreshed = "3. Last Refreshed"
        case timeZone = "4. Time Zone"
    }
}

struct WeeklyAdjustedTimeSery: Codable {
    let open, high, low, close: String
    let adjustedClose, volume, dividendAmount: String

    enum CodingKeys: String, CodingKey {
        case  open = "1. open"
        case  high = "2. high"
        case  low = "3. low"
        case  close = "4. close"
        case  adjustedClose = "5. adjusted close"
        case  volume = "6. volume"
        case  dividendAmount = "7. dividend amount"
    }
}

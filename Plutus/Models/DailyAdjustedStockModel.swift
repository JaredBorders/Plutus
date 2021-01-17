//
//  DataModels.swift
//
//  Created by Musa Kokcen on 17.01.2021.
//

import Foundation
struct DailyAdjustedStockModel: Codable {
    let metaData: DailyMetaData
    let timeSeriesDaily: [String: TimeSeriesDaily]

    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeriesDaily = "Time Series (Daily)"
    }
}

struct DailyMetaData: Codable {
    let information, symbol, lastRefreshed, outputSize: String
    let timeZone: String

    enum CodingKeys: String, CodingKey {
        case information = "1. Information"
        case symbol = "2. Symbol"
        case lastRefreshed = "3. Last Refreshed"
        case outputSize = "4. Output Size"
        case timeZone = "5. Time Zone"
    }
}

struct TimeSeriesDaily: Codable {
    let open, high, low, close: String
    let adjustedClose, volume, dividendAmount, splitCoefficient: String

    enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case high = "2. high"
        case low = "3. low"
        case close = "4. close"
        case adjustedClose = "5. adjusted close"
        case volume = "6. volume"
        case dividendAmount = "7. dividend amount"
        case splitCoefficient = "8. split coefficient"
    }
}

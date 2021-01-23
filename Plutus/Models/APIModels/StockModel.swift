//
//  StockModel.swift
//  Plutus
//
//  Created by Musa Kokcen on 23.01.2021.
//

import Foundation

// api url: https://polygon.io/docs/get_v1_open-close__stocksTicker___date__anchor

enum StockDataRange {
    case day, week, month
    
    var strigValue: String {
        switch self {
        case .day:
            return "day"
        case .week:
            return "week"
        case .month:
            return "month"
        }
    }
}

struct StockQueryModel {
    let ticker: StockMarketIndex
    let timespan: StockDataRange
    let from: Date
}

struct StockModel: Codable {
    let ticker: String
    let queryCount, resultsCount: Int
    let adjusted: Bool
    let results: [StockResult]
    let status, requestID: String
    let count: Int

    enum CodingKeys: String, CodingKey {
        case ticker, queryCount, resultsCount, adjusted, results, status
        case requestID = "request_id"
        case count
    }
}

// MARK: - Result
struct StockResult: Codable {
    let v: Int
    let vw, o, c, h: Double
    let l: Double
    let t: Int
}

//struct StockModel: Codable {
//    let ticker: String //The exchange symbol that this item is traded under.
//    let queryCount, resultsCount: Int //querycount: The number of aggregates (minute or day) used to generate the response. resultsCount: The total number of results for this request.
//    let adjusted: Bool //Whether or not this response was adjusted for splits.
//    let results: [ModelResult]
//    let status, requestID: String
//    let count: Int
//
//}
//
//// MARK: - Result
//struct ModelResult: Codable {
//    let v: Int
//    let vw, o, c, h: Double
//    let l: Double
//    let t: Int
//}


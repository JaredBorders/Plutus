//
//  Endpoints.swift
//  Plutus
//
//  Created by Musa Kokcen on 17.01.2021.
//

import Foundation

enum Endpoint {
    case genericCrypto(query: CryptoQueryModel)
    case genericStock(query: StockQueryModel)
    
    private var apiKey: String {
        switch self {
        case .genericStock:
            return "Z10_lFqElYIzy666oIlE7FJZKOChbCBT"
        default:
            return ""
        }
    }

    private var baseUrl: String {
        switch self {
        case .genericStock:
            return "https://api.polygon.io/v2/"
        case .genericCrypto:
            return "https://api.coingecko.com/api/v3/"
        }
    }
    
    var path: String {
        switch self {
        case .genericStock(let query):
            var fromDate = query.from
            
            if let day = fromDate.dayNumberOfWeek() {
                if day == 7 {
                    if let date = Calendar.current.date(byAdding: .day, value: -2, to: fromDate) {
                        fromDate = date
                    }
                } else if day == 6 {
                    if let date = Calendar.current.date(byAdding: .day, value: -2, to: fromDate) {
                        fromDate = date
                    }
                }
            }
            
            var toDate = fromDate
            
            switch query.timespan {
            case .day:
                if let date = Calendar.current.date(byAdding: .weekday, value: -7, to: fromDate) {
                    toDate = date
                }
            case .week:
                if let date = Calendar.current.date(byAdding: .weekOfYear, value: -7, to: fromDate) {
                    toDate = date
                }
            case .month:
                if let date = Calendar.current.date(byAdding: .month, value: -7, to: fromDate) {
                    toDate = date
                }
            }
            
            
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd"
            let fromDateF = format.string(from: fromDate)
            let toDateF = format.string(from: toDate)

            return "\(baseUrl)aggs/ticker/\(query.ticker)/range/1/day/\(toDateF)/\(fromDateF)"
        case .genericCrypto(let query):
            return "\(baseUrl)coins/\(query.symbol)/market_chart"

        }
    }
    
    var params: [String : Any] {
        switch self {
        case .genericStock:
            return ["unadjusted": true,
                    "sort": "asc",
                    "apiKey": apiKey]
            
        case .genericCrypto(let range):
            return ["vs_currency": "USD",
                    "days": range.numberOfData,
                    "interval": range.interval]
        }
    }
}

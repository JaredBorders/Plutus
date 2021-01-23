//
//  ChartStore.swift
//  Plutus
//
//  Created by Elena Sadler on 1/17/21.
//

import Foundation
import SwiftUICharts

struct TimeSeriesDigitalCurrencyDaily: Codable {
    let openCNY, openUSD, highCNY,highUSD: String?
    let lowCNY, lowUSD, closeCNY, closeUSD: String?
    let volume, marketCapUSD: String?

    enum CodingKeys: String, CodingKey {
        case openCNY = "1a. open (CNY)"
        case openUSD = "1b. open (USD)"
        case highCNY = "2a. high (CNY)"
        case highUSD = "2b. high (USD)"
        case lowCNY = "3a. low (CNY)"
        case lowUSD = "3b. low (USD)"
        case closeCNY = "4a. close (CNY)"
        case closeUSD = "4b. close (USD)"
        case volume = "5. volume"
        case marketCapUSD = "6. market cap (USD)"
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

class ChartStore: ObservableObject {
    @Published var stockData = [TimeSeriesDaily]()
    @Published var cryptoData = [TimeSeriesDigitalCurrencyDaily]()
    
    func fetchDaily() {
//        NetworkManager.shared.request(type: DailyAdjustedStockModel.self, endpoint: .dailyAdjustedStock(symbol: "IBM")) {
//            [weak self] result in
//            guard let self = self else { return }
//
//            switch result {
//            case .success(let stocks):
//                self.stockData = stocks.timeSeriesDaily.map { $0.value }
//            case .failure(let error):
//                print(error)
//            }
//        }
//
//        NetworkManager.shared.request(type: DailyAdjustedCryptoModel.self, endpoint: .dailyAdjustedCrypto(symbol: .BTC, market: .USD)) {
//            [weak self] result in
//            guard let self = self else { return }
//
//            switch result {
//            case .success(let cryptos):
//                self.cryptoData = cryptos.timeSeriesDigitalCurrencyDaily.map { $0.value }
//            case .failure(let error):
//                print(error)
//            }
//        }
    }

    func getDataForCryptoChart() -> [Double] {
        var result = [Double]()

        for day in cryptoData {
            guard let openUSD = day.openUSD else { continue }
            guard let doubleValue = Double(openUSD) else { continue }
            result.append(doubleValue)
        }

        return result
    }

    func getDataForStockChart() -> [Double] {
        var result = [Double]()

        for day in stockData {
            guard let doubleValue = Double(day.open) else { continue }
            result.append(doubleValue)
        }

        return result
    }
}

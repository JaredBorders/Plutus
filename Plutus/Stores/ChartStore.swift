//
//  ChartStore.swift
//  Plutus
//
//  Created by Elena Sadler on 1/17/21.
//

import Foundation
import SwiftUICharts

class ChartStore: ObservableObject {
    @Published var stockData = [TimeSeriesDaily]()
    @Published var cryptoData = [TimeSeriesDigitalCurrencyDaily]()
    
    func fetchDaily() {
        NetworkManager.shared.request(type: DailyAdjustedStockModel.self, endpoint: .dailyAdjustedStock(symbol: "IBM")) {
            [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let stocks):
                self.stockData = stocks.timeSeriesDaily.map { $0.value }
            case .failure(let error):
                print(error)
            }
        }

        NetworkManager.shared.request(type: DailyAdjustedCryptoModel.self, endpoint: .dailyAdjustedCrypto(symbol: .BTC, market: .USD)) {
            [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let cryptos):
                self.cryptoData = cryptos.timeSeriesDigitalCurrencyDaily.map { $0.value }
            case .failure(let error):
                print(error)
            }
        }
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

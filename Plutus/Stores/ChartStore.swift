//
//  ChartStore.swift
//  Plutus
//
//  Created by Elena Sadler on 1/17/21.
//

import Foundation
import SwiftUICharts

class ChartStore: ObservableObject {
    @Published var chartData1 = [TimeSeriesDaily]()
    @Published var chartData2 = [Double]()
    
    
    func fetchDaily() {
        NetworkManager.shared.request(type: DailyAdjustedStockModel.self, endpoint: .dailyAdjustedStock(symbol: "IBM")) { (result) in
            switch result {
            case .success(let stocks):
                self.chartData1 = stocks.timeSeriesDaily.map {
                    $0.value
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    func getDataForChart1() -> [Double] {
        var result = [Double]()
        for day in chartData1 {
            result.append(Double(day.open)!)
        }
        return result
    }
}

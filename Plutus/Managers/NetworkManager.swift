//
//  NetworkManager.swift
// Plutus

//  Created by Musa Kokcen on 17.01.2021.
//

import Foundation
import Alamofire

public typealias Completion<T> = (Result<T, Error>) -> Void where T: Decodable

public class EmptyResponse: Codable {
    public init() {}
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    public init(sessionManager: Alamofire.Session = Alamofire.Session(configuration: URLSessionConfiguration.default)) {
        self.session = sessionManager
    }
    
    private var possibleEmptyBodyResponseCodes: Set<Int> {
        var defaultSet = DataResponseSerializer.defaultEmptyResponseCodes
        defaultSet.insert(200)
        defaultSet.insert(201)
        return defaultSet
    }
    
    private let session: Alamofire.Session
    private let method = HTTPMethod.get
    let baseUrl: String = "https://www.alphavantage.co/query?"
    private let favouriteComparisonsGroup = DispatchGroup()
    
    public func request<T: Decodable>(type: T.Type, endpoint: Endpoint, completion: @escaping Completion<T>){
        session.request(baseUrl,
                        method: method,
                        parameters: endpoint.params,
                        encoding: URLEncoding.default)
            .validate()
            .response(responseSerializer: DataResponseSerializer(emptyResponseCodes: possibleEmptyBodyResponseCodes), completionHandler: { (response) in
                
                switch response.result {
                case .success(let data):
                    guard !data.isEmpty else {
                        completion(.success(EmptyResponse() as! T))
                        return
                    }
                    
                    do {
                        let decodedObject = try JSONDecoder().decode(type, from: data)
                        completion(.success(decodedObject))
                    } catch let err {
                        completion(.failure(err))
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            })
    }
    
    public func requestComparison(comparison: FavoriteComparison, completion: @escaping Completion<AnalysisModel>){
        var comparisonData: AnalysisModel!
        var dailyCryptoData: DailyAdjustedCryptoModel?
        var dailyStockData: DailyAdjustedStockModel?
        var weeklyCryptoData: WeeklyAdjustedCryptoModel?
        var weeklyStockData: WeeklyAdjustedStockModel?
        var monthlyCryptoData: MonthlyAdjustedCryptoModel?
        var monthlyStockData: MonthlyAdjustedStockModel?
        
        switch comparison.timeRange {
        case .Day:
            favouriteComparisonsGroup.enter()
            request(type: DailyAdjustedCryptoModel.self, endpoint: .dailyAdjustedCrypto(symbol: comparison.crypto)) { (result) in
                switch result {
                case .success(let data):
                    dailyCryptoData = data
                    self.favouriteComparisonsGroup.leave()
                case .failure(let err):
                    print(err)
                    self.favouriteComparisonsGroup.leave()
                }
            }
            
            favouriteComparisonsGroup.enter()
            request(type: DailyAdjustedStockModel.self, endpoint: .dailyAdjustedStock(symbol: comparison.stock.rawValue)) { (result) in
                switch result {
                case .success(let data):
                    dailyStockData = data
                case .failure(let err):
                    print(err)
                }
                self.favouriteComparisonsGroup.leave()
            }
            
            
        case .Week:
            //            favouriteComparisonsGroup.enter()
            //            request(type: WeeklyAdjustedCryptoModel.self, endpoint: .weeklyAdjustedCrypto(symbol: comparison.crypto)) { (result) in
            //                switch result {
            //                case .success(let data):
            //                    weeklyCryptoData = data
            //                case .failure(let err):
            //                    print(err)
            //                }
            //                self.favouriteComparisonsGroup.leave()
            //            }
            //
            print("weekly")
        case .Month:
            //            favouriteComparisonsGroup.enter()
            //            request(type: MonthlyAdjustedCryptoModel.self, endpoint: .monthlyAdjustedCrypto(symbol: comparison.crypto)) { (result) in
            //                switch result {
            //                case .success(let data):
            //                    monthlyCryptoData = data
            //                case .failure(let err):
            //                    print(err)
            //                }
            //                self.favouriteComparisonsGroup.leave()
            //            }
            //
            //            favouriteComparisonsGroup.enter()
            //            request(type: MonthlyAdjustedStockModel.self, endpoint: .monthlyAdjustedStock(symbol: comparison.stock.rawValue)) { (result) in
            //                switch result {
            //                case .success(let data):
            //                    monthlyStockData = data
            //                case .failure(let err):
            //                    print(err)
            //                }
            //                self.favouriteComparisonsGroup.leave()
            //            }
            print("monthly")
        case .Year:
            break
        }
        
        favouriteComparisonsGroup.notify(queue: .main) {
            switch comparison.timeRange {
            case .Day:
                
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US_POSIX")
                let yymmdd: String = "yyyy-MM-dd"
                formatter.dateFormat = yymmdd
                let date = formatter.string(from: Date())
                
                let cryptoValue = dailyCryptoData?.timeSeriesDigitalCurrencyDaily[date]?.closeUSD
                var cryptoDiff: String!
                
                if let open = dailyCryptoData?.timeSeriesDigitalCurrencyDaily[date]?.openUSD, let cryptoOpen = Float(open), let close = dailyCryptoData?.timeSeriesDigitalCurrencyDaily[date]?.closeUSD, let cryptoClose = Float(close) {
                    let diff = cryptoOpen - cryptoClose
                    cryptoDiff = String(diff / cryptoClose)
                }
                
                let stockValue = dailyStockData?.timeSeriesDaily["2021-01-14"]?.close
                var stockDiff: String!
                
                if let open = dailyStockData?.timeSeriesDaily["2021-01-14"]?.open, let stockOpen = Float(open), let close = dailyStockData?.timeSeriesDaily["2021-01-14"]?.close, let stockClose = Float(close) {
                    stockDiff = String(stockOpen - stockClose)
                }
                
                let watchList = WathclistModel(crypto: comparison.crypto, stock: comparison.stock, cryptoValue: cryptoValue!, cryptoDifference: cryptoDiff, stockValue: stockValue!, stockDifference: stockDiff)
                comparisonData = AnalysisModel(timeRange: comparison.timeRange, watchlist: watchList)
                completion(.success(comparisonData))
                
                
                
            case .Week:
                if let cryptoKey = dailyCryptoData?.timeSeriesDigitalCurrencyDaily.keys.first, let stockKey = dailyStockData?.timeSeriesDaily.keys.first  {
                    let cryptoValue = dailyCryptoData?.timeSeriesDigitalCurrencyDaily[cryptoKey]?.closeUSD
                    
                    let stockValue = dailyStockData?.timeSeriesDaily[stockKey]?.close
                }
            case .Month:
                if let cryptoKey = dailyCryptoData?.timeSeriesDigitalCurrencyDaily.keys.first, let stockKey = dailyStockData?.timeSeriesDaily.keys.first  {
                    let cryptoValue = dailyCryptoData?.timeSeriesDigitalCurrencyDaily[cryptoKey]?.closeUSD
                    
                    let stockValue = dailyStockData?.timeSeriesDaily[stockKey]?.close
                }
            case .Year:
                break
            }
        }
    }
}

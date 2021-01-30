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
    
    public func request<T: Decodable>(type: T.Type, endpoint: Endpoint, completion: @escaping Completion<T>){
        session.request(endpoint.path,
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
    
    public func requestComparison(comparison: FavoriteComparison, completion: @escaping Completion<ComparisonValueModel>){
        var cryptoData: CryptoModel?
        var stockData: StockModel?
        
        var stockTimeRange: StockDataRange?
        var cryptoTimeRange: CryptoDataRange?
                
        switch comparison.timeRange {
        case .Day:
            stockTimeRange = .day
            cryptoTimeRange = .daily
        case .Week:
            stockTimeRange = .week
            cryptoTimeRange = .weekly
        case .Month:
            stockTimeRange = .month
            cryptoTimeRange = .monthly
        case .Year:
            break
        }
        
        request(type: CryptoModel.self, endpoint: .genericCrypto(query: CryptoQueryModel(interval: cryptoTimeRange ?? .daily, numberOfData: 7, symbol: comparison.crypto.id))) { (result) in
            switch result {
            case .success(let data):
                cryptoData = data
                if  let cryptoData = cryptoData, let stock = stockData {
                    let comparisonData = ComparisonValueModel(timeRange: comparison.timeRange, cryptoName: comparison.crypto, stockName: comparison.stock, crypto: cryptoData, stock: stock)
                    completion(.success(comparisonData))
                }
            case .failure(let err):
                completion(.failure(err))
            }
        }
        
        request(type: StockModel.self, endpoint: .genericStock(query: StockQueryModel(ticker: comparison.stock, timespan: stockTimeRange ?? .day, from: Date()))) { (result) in
            switch result {
            case .success(let data):
                stockData = data
                if let cryptoData = cryptoData, let stock = stockData {
                    let comparisonData = ComparisonValueModel(timeRange: comparison.timeRange, cryptoName: comparison.crypto, stockName: comparison.stock, crypto: cryptoData, stock: stock)
                    completion(.success(comparisonData))
                }
            case .failure(let err):
                completion(.failure(err))
            }
        }
        
    }
}

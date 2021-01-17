//
//  NetworkManager.swift
// Plutus

//  Created by Musa Kokcen on 17.01.2021.
//

import Foundation
import Alamofire

enum Endpoint {
    case dailyAdjustedStock(symbol: String), weeklyAdjustedStock(symbol: String), monthlyAdjustedStock(symbol: String), searchStock(keyword: String)
    case dailyAdjustedCrypto(symbol: String), weeklyAdjustedCrypto(symbol: String), monthlyAdjustedCrypto(symbol: String)

    var function: String {
        switch self {
        case .dailyAdjustedStock:
            return "TIME_SERIES_DAILY_ADJUSTED"
        case .weeklyAdjustedStock:
            return "TIME_SERIES_WEEKLY_ADJUSTED"
        case .monthlyAdjustedStock:
            return "TIME_SERIES_MONTHLY_ADJUSTED"
        case .searchStock:
            return "SYMBOL_SEARCH"
        case .dailyAdjustedCrypto:
            return "DIGITAL_CURRENCY_DAILY"
        case .weeklyAdjustedCrypto:
            return "DIGITAL_CURRENCY_WEEKLY"
        case .monthlyAdjustedCrypto:
            return "DIGITAL_CURRENCY_MONTHLY"
        }
    }
    
    private var apiKey: String {
        return "6SX5O39UR4QV8V4L"
    }

    var params: [String : Any] {
        switch self {
        case .dailyAdjustedStock(let symbol), .weeklyAdjustedStock(let symbol), .monthlyAdjustedStock(let symbol):
                return [
                    "function": function,
                    "symbol": symbol,
                    "apikey": "6SX5O39UR4QV8V4L"
                ]
        case .searchStock(let keyword):
            return [
                "function": function,
                "keywords": keyword,
                "apikey": apiKey
            ]
        case .dailyAdjustedCrypto(let symbol), .weeklyAdjustedCrypto(let symbol), .monthlyAdjustedCrypto(let symbol):
            return [
                "function": function,
                "symbol": symbol,
                "apikey": apiKey
            ]
        }
    }
}

public typealias Completion<T> = (Result<T, Error>) -> Void where T: Decodable

public class EmptyResponse: Codable {
    public init() {}
}

final class NetworkManager {
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
}

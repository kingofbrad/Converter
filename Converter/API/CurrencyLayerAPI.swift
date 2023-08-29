//
//  CurrencyLayerAPI.swift
//  Converter
//
//  Created by Bradlee King on 26/08/2023.
//

import Foundation


class CurrencyLayer {
    static let shared = CurrencyLayer()
    
    private var accessKey: String = Environment.value(for: .currencyLayerAccessKey)
    
    var baseURL : URL {
        URL(string: "http://api.currencylayer.com")!
    }
    
    enum Endpoint {
        case currencies
        case rates
        
        var path: String {
            switch self {
            case .currencies: return "/list"
            case.rates: return "/live"
            }
        }
    }
    
    func genEndPointURL(for endPoint: Endpoint) -> URL {
        return URL(string: "\(baseURL)\(endPoint.path)?access_key=\(accessKey)")!
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    func fetchCurrencies(completionHandler: @escaping ([Currency]) -> Void, errorHandler: @escaping(Error) -> Void) {
        URLSession.shared.dataTask(with: genEndPointURL(for: .currencies), completionHandler: {(data, response, error) in
            do {
                if let data = data {
                    let response = try JSONSerialization.jsonObject(with: data, options: [])
                    if let dictionary = response as? [String: Any], let currenciesJSON = dictionary["currencies"] as? [String : String] {
                        DispatchQueue.main.async {
                            completionHandler(currenciesJSON.map{ Currency(code: $0.key, name: $0.value)})
                        }
                    }
                }
            }
            catch let error {
                errorHandler(error)
            }
        }).resume()
    }
    func fetchRates(completionHandler: @escaping ([Rate]) -> Void, errorHandler: @escaping (Error) -> Void) {
        URLSession.shared.dataTask(with: genEndPointURL(for: .rates), completionHandler: {(data, response, error) in
            do {
                if let data = data {
                    let response = try JSONSerialization.jsonObject(with: data, options: [])
                    if let dictionary = response as? [String: Any], let ratesJSON = dictionary["quotes"] as? [String: Double] {
                        DispatchQueue.main.async {
                            completionHandler(ratesJSON.map{Rate(code: $0.key, value: $0.value) })
                        }
                    }
                }
            }
            catch let error {
                errorHandler(error)
            }
        }).resume()
    }
}

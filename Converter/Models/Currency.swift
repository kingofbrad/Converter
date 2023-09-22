//
//  Currency.swift
//  Converter
//
//  Created by Bradlee King on 26/08/2023.
//

import Foundation


struct Currency: Codable, Hashable {
    var code: String
    var name: String
    
    static let defaultCurrency = Currency(code: "GBP", name: "British Pound Sterling")
    static let defaultCurrenciesList = [
            Currency(code: "CNY", name: "Chinese Yuan"),
            Currency(code: "EUR", name: "Euro"),
            Currency(code: "JPY", name: "Japanese Yen"),
            Currency(code: "KRW", name: "South Korean Won"),
            Currency(code: "USD", name: "United States Dollar")
       
    ]
}

//
//  ContentView.swift
//  Converter
//
//  Created by Bradlee King on 01/08/2023.
// https://api.exchangerate.host/latest?base=\(base)&amount=\(input)

//TextField("Enter an Amount", text: $input)
//.keyboardType(.decimalPad)
//.focused($inputIsFocused)

import SwiftUI


enum Countries: String, CaseIterable, Identifiable {
    case pound = "GBP"
    case dollars = "USD"
    case yen = "JPY"
    
    var id: Countries{self}
}

struct ContentView: View {
    @State var input = "1"
    // Amount to be converted
    @State var base = "GBP"
    // Base value for api to fetch the default exchange rate
    @State var showSheet: Bool = false
    // Toggle Fuction to display all the exchance rates
    @State private var fromCurrency: Countries = .pound
    @State private var toCurrency: Countries = .yen
    @State var currencyList = [String]()
    @FocusState private var inputIsFocused: Bool
    @State private var text: String = ""
    
    func makeRequest(showAll: Bool, currencies: [String] = ["USD", "GBP", "EUR"]) {
        apiRequest(url: "https://api.exchangerate.host/latest?base=\(fromCurrency)&amount=\(input)") { currency in
            //print("ContentView", currency.rates)
            var tempList = [String]()
            
            for currency in currency.rates {
                
                if showAll {
                    tempList.append("\(currency.key) \(String(format: "%.2f",currency.value))")
                } else if currencies.contains(currency.key)  {
                    tempList.append("\(currency.key) \(String(format: "%.2f",currency.value))")
                }
                tempList.sort()
            }
            currencyList.self = tempList
            
        }
    }
    
    
    func makeConvertRequest(currencies: [String] = []) {
        apiRequest(url: "https://api.exchangerate.host/convert?from=\(fromCurrency)&to=\(toCurrency)") { currency in
            var list = [String]()
            for currency in currency.rates {
                list.append("\(currency.key) \(String(format: "%.2F", currency.value))")
            }
            
            
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    
                    Picker("Base Rate", selection: $fromCurrency) {
                        ForEach(Countries.allCases) { category in
                            Text(category.rawValue).tag(category)
                                
                        }
                        
                    }
                    .pickerStyle(.navigationLink)
                    .frame(width: 180, height: 20)
                    .foregroundColor(Color.black)
                    .padding()
                    .background(Color.gray.opacity(0.10))
                    .cornerRadius(10.0)
                    .padding()
                    
                    
                    
                    
                    
                    
                    
                    Picker("Converted Rate", selection: $toCurrency) {
                        ForEach(Countries.allCases) { category in
                            Text(category.rawValue).tag(category)
                        }
                        
                    }
                    .pickerStyle(.navigationLink)
                    .frame(width: 180, height: 20)
                    .padding()
                    .background(Color.gray.opacity(0.10))
                    .cornerRadius(10.0)
                    
                    
                    TextField("Enter an currency", text: $base)
                        .padding()
                        .background(Color.gray.opacity(0.10))
                        .cornerRadius(20.0)
                        .padding()
                        .focused($inputIsFocused)
                    Button("Convert") {
                        makeRequest(showAll: false, currencies: ["GBP", "PLN", "JPY"])
                    }
                    Button("Exchange Rates") {
                        showSheet = true
                    }
                }
            }
            .sheet(isPresented: $showSheet, content: {
                AllView(input: $input, base: $base)
                    .presentationDetents([.height(350)])
            })
            
            .onAppear {
                makeRequest(showAll: true)
            }
            .toolbar {
                
            }
            .navigationTitle("Currency")
            Spacer()
        }
        
        
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView()
        }
        
    }
}


//
//  FilteredView.swift
//  Converter
//
//  Created by Bradlee King on 01/08/2023.
//

import SwiftUI

struct AllView: View {
    @Binding var input: String
    @Binding var base: String
    @State var currencyList = [String]()
    @State private var searchText: String = ""
    
    func makeRequest(showAll: Bool) {
        apiRequest(url: "https://api.exchangerate.host/latest?base=\(base)&amount=\(input)") { currency in
            var list = [String]()
            
            for currency in currency.rates {
                if showAll {
                    list.append("\(currency.key) \(String(format: "%.2f", currency.value))")
                }
                list.sort()
            }
            currencyList.self = list
            
            
        }
    }
    
    var searchableCurrency: [String] {
        if searchText.isEmpty {
            return currencyList
        } else {
            return currencyList.filter{$0.localizedCaseInsensitiveContains(searchText)}
        }
    }
    var body: some View {
        NavigationStack {
        VStack {
            List {
                ForEach(searchableCurrency, id: \.self) {
                    currency in
                    Text(currency).searchCompletion(currency)
                }
            }
        }
        .onAppear {
            makeRequest(showAll: true)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                    Text("All Currencies")
              
            }
            ToolbarItem(placement: .navigationBarLeading) {
                TextField("Enter Amount", text: $input)
                    .frame(width: 150)
                    .background(Color(.lightGray))
                    .multilineTextAlignment(.center)
                    
                    
            }
//            .onChange(of: $input) {
//                makeRequest(showAll: true)
//            }
        }
    }
        .searchable(text: $searchText)
    }
    
}

struct FilteredView_Previews: PreviewProvider {
    static var previews: some View {
       ContentView()
    }
}

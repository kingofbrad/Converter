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

struct ContentView: View {
    @ObservedObject var vm = CurrencyViewModel.shared
    @State var currentCurrency: Currency = Currency.defaultCurrency
    @State var amount: String = "1"
    @State var showCurrenciesSheet: Bool = false
    
    
    var body: some View {
        NavigationView {
            Form {
                Section() {
                    Picker(selection: $currentCurrency, label: Text(currentCurrency.code)) {
                        ForEach(vm.currencies.sorted {$0.name < $1.name}, id: \.code) { currency in
                            Text(currency.name)
                                .tag(currency)
                        }
                    }
                    TextField("Amount", text: $amount)
                        .font(.title)
                        .modifier(TextFieldClearButton(text: $amount))
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .frame(height: rowHeight)
                        .onChange(of: amount) { value in
                            vm.checkRatesExpiration()
                        }
                }
                Section() {
                    HStack {
                        Text("Last Update:")
                        Spacer()
                        Text(lastUpdate())
                    }
                    .font(.subheadline)
                }
                Section() {
                    ForEach(vm.showCurrencies, id: \.code) { currency in
                        HStack(alignment: .center, spacing: nil) {
                            VStack {
                                Text(currency.code)
                            }
                            Spacer()
                            Text(rateConvertion(to: currency))
                                .font(.title)
                        }
                        .frame(height: rowHeight)
                    }
                    .onDelete(perform: vm.removeCurrency)
                    Button(action: {showCurrenciesSheet.toggle()}) {
                        HStack {
                            Spacer()
                            Image(systemName: "plus")
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Currency Converter")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {showCurrenciesSheet.toggle()}) {
                        Text(Image(systemName: "plus"))
                    }
                }
            }
        }
        .sheet(isPresented: $showCurrenciesSheet,
               content: {
            NavigationView {
                List {
                    ForEach(vm.currencies.sorted { $0.name < $1.name}.filter{!vm.showCurrencies.contains($0)}, id: \.code) { currency in
                        Button {
                            vm.add(currency: currency)
                            showCurrenciesSheet.toggle()
                        } label: {
                            Text(currency.name)
                                
                        }
                        
                    }
                    
                }
                .navigationTitle("Currencies")
            }
        })
    }
    
    
    private var rowHeight: CGFloat = 50
    
    private func lastUpdate() -> String {
        if let lastUpdate = vm.lastUpdate {
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .short
            return dateFormatter.string(from: lastUpdate)
        }
        return ""
    }
    
    private func rateConvertion(to currency: Currency) -> String {
        if let amount = Double(amount) {
            return String(format: "%.2f", vm.convert(from: currentCurrency, to: currency, amount: amount))
        }
        return "-"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  CustomComponents.swift
//  Converter
//
//  Created by Bradlee King on 02/08/2023.
//

import SwiftUI

struct CustomComponents: View {
    var body: some View {
        TabView {
            EmptyView()
                .tabItem {
                    Label("Currency", image: "\(CurrencyIcon())")
                }
        }
    }
}

struct CurrencyIcon: View {
    var body: some View {
        HStack {
            Image(systemName: "sterlingsign.square")
                .resizable()
                .frame(width: 45, height: 30)
            Image(systemName: "yensign.square.fill")
                .resizable()
                .frame(width: 45, height: 30)
                .foregroundColor(.gray)
                .offset(x: -20, y: 10)
        }
    }
}

struct CustomComponents_Previews: PreviewProvider {
    static var previews: some View {
        CustomComponents()
    }
}

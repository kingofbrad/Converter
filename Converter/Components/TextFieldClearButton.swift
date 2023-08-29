//
//  TextFieldClearButton.swift
//  Converter
//
//  Created by Bradlee King on 29/08/2023.
//

import SwiftUI

struct TextFieldClearButton: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        HStack {
            if !text.isEmpty {
                Button(
                    action: {self.text = ""},
                    label: {
                        Image(systemName: "delete.right")
                            .foregroundColor(Color(UIColor.opaqueSeparator))
                    }
                )
            }
            
            content
        }
    }
}

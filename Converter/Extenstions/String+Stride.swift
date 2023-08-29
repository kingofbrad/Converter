//
//  String+Stride.swift
//  Converter
//
//  Created by Bradlee King on 29/08/2023.
//

import Foundation

extension String {
    func components(withLength length: Int) -> [String] {
        return stride(from: 0, to: self.count, by: length).map {
            let start = self.index(self.startIndex, offsetBy: $0)
            let end = self.index(start, offsetBy: length, limitedBy: self.endIndex) ?? self .endIndex
            return String(self[start..<end])
        }
    }
}

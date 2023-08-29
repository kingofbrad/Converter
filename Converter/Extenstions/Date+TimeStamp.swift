//
//  Date+TimeStamp.swift
//  Converter
//
//  Created by Bradlee King on 29/08/2023.
//

import Foundation

extension Date {
    var iso8601Calendar: Calendar {
        let calendar = Calendar(identifier: .iso8601)
        return calendar
    }
    
    var iso8601Formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.calendar = iso8601Calendar
        return formatter
    }
    
    func minutesFromNow(date: Date) -> Int {
        let now = Date()
        let components = iso8601Calendar.dateComponents([.minute], from: date, to: now)
        return components.minute!
    }
}

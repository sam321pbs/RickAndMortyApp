//
//  DateUtils.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/27/23.
//

import UIKit

/// Helps with dates
struct DateUtils {
    
    // https://nsdateformatter.com
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.timeZone = .current
        return formatter
    }()
    
    static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    static func convertToReadableShortDate(from date: String) -> String {
        if let createdDate = self.dateFormatter.date(from: date) {
            return self.shortDateFormatter.string(from: createdDate)
        }
        return date
    }
}

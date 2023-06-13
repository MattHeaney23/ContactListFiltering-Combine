//
//  Date+ConvertToReadableDate.swift
//  ContactListFiltering
//
//  Created by Matt on 13/06/2023.
//

import Foundation

extension Date {
    /// Converts a date to a readable "HH:mm, dd MMMM" format
    func convertToReadableDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm, dd MMMM"
        return dateFormatter.string(from: self)
    }
}

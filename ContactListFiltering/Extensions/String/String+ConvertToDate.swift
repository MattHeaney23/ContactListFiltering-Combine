//
//  String+ConvertToDate.swift
//  ContactListFiltering
//
//  Created by Matt on 13/06/2023.
//

import Foundation

extension String {
    /// Converts a string in "yyyy-MM-dd'T'HH:mm:ssZ" format, to a date
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: self)
    }
}

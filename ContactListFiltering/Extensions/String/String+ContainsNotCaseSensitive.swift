//
//  String+ContainsNotCaseSensitive.swift
//  ContactListFiltering
//
//  Created by Matt on 13/06/2023.
//

import Foundation

extension String {
    public func containsNotCaseSensitive(_ other: String) -> Bool {
        return self.lowercased().contains(other.lowercased())
    }
}

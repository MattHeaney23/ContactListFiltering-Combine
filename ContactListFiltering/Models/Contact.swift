//
//  Contact.swift
//  ContactListFiltering
//
//  Created by Matt on 12/06/2023.
//

import Foundation

class Contact: Codable {
    let name: String
    let username: String
    let userID: Int
    let profilePictureURL: String
    let currentlyOnline: Bool
    /// Last online is nil if the user is currently online
    let lastOnline: String?
    
    var displayableLastOnlineTime: String? {
        guard let lastOnline else { return nil }
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: lastOnline) else { return "2" }
        
        let dateFormatterGet2 = DateFormatter()
        dateFormatterGet2.dateFormat = "HH:mm, dd MMMM"

        return dateFormatterGet2.string(from: date)
    }
}

extension Contact: Identifiable {
    var id: Int {
        self.userID
    }
}

extension Contact: Equatable {
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.id == rhs.id
    }
}

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

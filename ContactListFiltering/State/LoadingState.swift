//
//  LoadingState.swift
//  ContactListFiltering
//
//  Created by Matt on 14/06/2023.
//

import Foundation

enum LoadingState<T> {
    case loading
    case ready(T)
    case error(Error)
}

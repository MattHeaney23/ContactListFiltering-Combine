//
//  NetworkService.swift
//  ContactListFiltering
//
//  Created by Matt on 12/06/2023.
//

import Combine
import Foundation

class NetworkService<T: Codable> {
    
    /// Requests data, emitting the generic type
    func fetchData(url: URL) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

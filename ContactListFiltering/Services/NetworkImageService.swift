//
//  NetworkImageService.swift
//  ContactListFiltering
//
//  Created by Matt on 12/06/2023.
//

import Combine
import UIKit

enum NetworkImageServiceError: Error {
    case invalidData
}

class NetworkImageService {
    func getImage(url: URL) -> AnyPublisher<UIImage, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .map { $0.data }
            .tryMap {
                guard let image = UIImage(data: $0) else { throw NetworkImageServiceError.invalidData }
                return image
            }
            //could use a replace error here to use a placeholder
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

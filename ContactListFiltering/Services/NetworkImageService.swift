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
    
    private init() {}
    static let shared = NetworkImageService()
    var cache: [URL: UIImage] = [:]
    
    func getImage(url: URL) -> AnyPublisher<UIImage, Error> {
        
        if let image = cache[url] {
            return Just(image)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return URLSession.shared.dataTaskPublisher(for: url)
                .delay(for: .seconds(0.1), scheduler: DispatchQueue.main)
                .subscribe(on: DispatchQueue.global(qos: .background))
                .map { $0.data }
                .tryMap { [weak self] in
                    guard let image = UIImage(data: $0) else { throw NetworkImageServiceError.invalidData }
                    
                    self?.cache[url] = image
                    
                    return image
                }
            //could use a replace error here to use a placeholder
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
    }
}

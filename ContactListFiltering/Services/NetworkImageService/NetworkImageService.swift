//
//  NetworkImageService.swift
//  ContactListFiltering
//
//  Created by Matt on 12/06/2023.
//

import Combine
import UIKit

class NetworkImageService {
    
    //MARK: Services
    private let cache = ImageCacheService.Shared
    
    //MARK: Fetching Image
    /// Makes a request to the url, after checking the cache. If a network request is required, a delay of 0.1 occurs before to allow for optimised rapid list scrolling
    func getImage(url: URL) -> AnyPublisher<UIImage, Error> {
        
        cache.imageFromCacheIfAvailable(url: url)
            .flatMap {
                if let image = $0 {
                    return Just(image)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                } else {
                    return self.getImageFromNetwork(url: url)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    private func getImageFromNetwork(url: URL) -> AnyPublisher<UIImage, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .delay(for: .seconds(0.1), scheduler: DispatchQueue.main)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .map { $0.data }
            .tryMap {
                guard let image = UIImage(data: $0) else { throw NetworkImageServiceError.invalidData }
                self.cache.storeImageInCache(image: image, url: url)
                return image
            }
            .eraseToAnyPublisher()
    }
}

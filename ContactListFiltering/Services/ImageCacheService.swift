//
//  ImageCacheService.swift
//  ContactListFiltering
//
//  Created by Matt on 13/06/2023.
//

import Combine
import UIKit

class ImageCacheService {
    //MARK: - Init
    private init() {}
    static let Shared = ImageCacheService()
    
    //MARK: - Properties
    private let imageCache = NSCache<AnyObject, AnyObject>()
    
    ///Load the image from cache. Returns nil if it doesn't exist in cache.
    func imageFromCacheIfAvailable(url: URL) -> Just<UIImage?> {
        let cacheKey = url.absoluteString as NSString
        return Just(imageCache.object(forKey: cacheKey) as? UIImage)
    }
    
    ///Stores the image cache, using the url as the key
    func storeImageInCache(image: UIImage?, url: URL) {
        guard let image = image else { return }
        let cacheKey = url.absoluteString as NSString
        self.imageCache.setObject(image, forKey: cacheKey)
    }
}

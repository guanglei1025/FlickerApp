//
//  CachedImageManager.swift
//  FlickerApp
//
//  Created by Guanglei Liu on 2/9/25.
//

import Foundation
import UIKit

class CachedImageManager {

    static let shared = CachedImageManager()

    private init() {}

    lazy var cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 100 * 1024 * 1024
        return cache
    }()

    func saveImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }

    func getImage(forKey key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }
}

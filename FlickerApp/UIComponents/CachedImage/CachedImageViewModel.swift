//
//  CachedImageViewModel.swift
//  FlickerApp
//
//  Created by Guanglei Liu on 2/9/25.
//

import Foundation
import Observation
import SwiftUI

@Observable
class CachedImageViewModel {

    var image: UIImage?

    private let cacheManager = CachedImageManager.shared

    private let imageURLString: String

    private let postId: String

    init(imageURLString: String, postId: String) {
        self.imageURLString = imageURLString
        self.postId = postId
    }
    
    /// Get cached image, otherwise download new image
    func loadImage() async {
        if let savedImage = cacheManager.getImage(forKey: postId) {
            image = savedImage
        } else {
            do {
                try await downloadImage()
            } catch {
                image = UIImage(systemName: "questionmark.circle")
            }
        }
    }

    func downloadImage() async throws {
        guard let url = URL(string: imageURLString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        if let image = UIImage(data: data) {
            self.image = image
            // Cache Image
            cacheManager.saveImage(image, forKey: postId)
        }
    }
}

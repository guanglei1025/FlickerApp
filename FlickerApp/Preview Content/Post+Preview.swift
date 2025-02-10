//
//  Post+Preview.swift
//  FlickerApp
//
//  Created by Guanglei Liu on 2/9/25.
//

import Foundation

extension Post {
    static func mock() -> Post {
        Post(title: "AAL_2920",
             description: "www.flickr.com",
             author: "nobody@flickr.com",
             timestamp: Date(),
             media: Media(imageURLString: "https://live.staticflickr.com/65535/54074976642_b17890fe61_m.jpg")
        )
    }
}

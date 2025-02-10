//
//  PostResponse.swift
//  FlickerApp
//
//  Created by Guanglei Liu on 2/9/25.
//

import Foundation

struct PostResponse: Decodable {
    let title: String
    let items: [Post]
}

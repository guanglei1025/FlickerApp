//
//  Post.swift
//  FlickerApp
//
//  Created by Guanglei Liu on 2/9/25.
//

import Foundation

struct Post: Decodable, Identifiable {
    var id = UUID()
    let title: String
    let description: String
    let author: String
    let timestamp: Date
    let media: Media

    /// Display time (1/21/2025, 11:57AM)
    var timestampDisplay: String {
        timestamp.formatted(date: .numeric, time: .shortened)
    }
    
    var imageURLString: String {
        media.imageURLString
    }

    enum CodingKeys: String, CodingKey {
        case title
        case description
        case author
        case timestamp = "date_taken"
        case media
    }
}

struct Media: Decodable {
    let imageURLString: String

    enum CodingKeys: String, CodingKey {
        case imageURLString = "m"
    }
}

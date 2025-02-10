//
//  PostAPIService.swift
//  FlickerApp
//
//  Created by Guanglei Liu on 2/9/25.
//

import Foundation

/// API layer, making network calls
protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}

class PostAPIService {

    private let session: URLSessionProtocol

    private let baseURL = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags="

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func fetchPosts(keyword: String) async throws -> [Post] {
        guard let url = URL(string: baseURL + keyword) else {
            throw URLError(.badURL)
        }
        let (data, response) = try await session.data(from: url)

        guard let response = response as? HTTPURLResponse,
              200..<300 ~= response.statusCode
        else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do {
            let postResponse = try decoder.decode(PostResponse.self, from: data)
            return postResponse.items
        } catch {
            throw error
        }
    }
}

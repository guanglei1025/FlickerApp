//
//  PostAPIServiceTests.swift
//  FlickerAppTests
//
//  Created by Guanglei Liu on 2/9/25.
//

import XCTest
@testable import FlickerApp

final class PostAPIServiceTests: XCTestCase {
    var sut: PostAPIService!
    var mockURLSession: MockURLSession!

    let mockJsonString = """
        {
            "title": "Recent Uploads tagged porcupine",
            "description": "",
            "modified": "2025-02-09T22:22:39Z",
            "items": [
                {
                    "title": "Cincinnati Zoo 2-9-25-00335",
                    "media": {
                        "m": "https://live.staticflickr.com/65535/54074976642_b17890fe61_m.jpg"
                    },
                    "date_taken": "2025-02-09T16:14:22-08:00",
                    "description": "Brazilian Porcupine",
                    "published": "2025-02-09T22:22:39Z",
                    "author": "nobody@flickr.com",
                    "author_id": "124191108@N08",
                    "tags": "cincinnati zoo botanical garden rico brazilian porcupine"
                }
            ]
        }
      """

    let expectedURL = URL(string: "https://api.flickr.com")!

    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
        sut = PostAPIService(session: mockURLSession)
    }

    override func tearDown() {
        sut = nil
        mockURLSession = nil
        super.tearDown()
    }

    func test_fetchPosts_passValidJSON_getPostsSuccess() async throws {
        let data = mockJsonString.data(using: .utf8)!
        let successResponse = HTTPURLResponse(url: expectedURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
        mockURLSession.response = .success((data, successResponse))

        let posts = try await sut.fetchPosts(keyword: "mockKeyword")

        XCTAssertNotNil(posts)
        XCTAssertEqual(posts.count, 1)
    }

    func test_fetchPosts_errorCode400_throwBadServerResponse() async throws {
        let data = mockJsonString.data(using: .utf8)!
        let failureResponse = HTTPURLResponse(url: expectedURL, statusCode: 400, httpVersion: nil, headerFields: nil)!
        mockURLSession.response = .success((data, failureResponse))

        do {
            let _ = try await sut.fetchPosts(keyword: "mockKeyword")
            XCTFail("Expected to throw an error for HTTP 400")
        } catch let error as URLError {
            XCTAssertEqual(error.code, .badServerResponse, "Expected URLError.badServerResponse for HTTP 400")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}

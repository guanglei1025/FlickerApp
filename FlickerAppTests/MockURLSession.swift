//
//  MockURLSession.swift
//  FlickerAppTests
//
//  Created by Guanglei Liu on 2/9/25.
//

import Foundation
@testable import FlickerApp

enum MockURLSessionError: Error {
    case responseNotSet
}

class MockURLSession: URLSessionProtocol {

    var response: Result<(Data, URLResponse), Error>?

    func data(from url: URL) async throws -> (Data, URLResponse) {
        switch response {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        case .none:
            throw MockURLSessionError.responseNotSet
        }
    }
}

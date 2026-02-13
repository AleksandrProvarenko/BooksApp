//
//  MockNetworkService.swift
//  BooksApp
//
//  Created by Alex Provarenko on 13.02.2026.
//

import Foundation

final class MockNetworkService: NetworkServiceProtocol {
    
    var result: Result<BooksResponse, Error> = .failure(APIError.invalidResponse)
    var receivedNextURL: URL?

    func fetchBooks(nextPageURL: URL?) async throws -> BooksResponse {
        receivedNextURL = nextPageURL
        return try result.get()
    }
}

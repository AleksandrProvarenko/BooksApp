//
//  BooksAPIService.swift
//  BooksApp
//
//  Created by Alex Provarenko on 12.02.2026.
//

import Foundation

final class BooksAPIService: NetworkServiceProtocol {
    
    private let session: URLSession
    private let baseURL = URL(string: "https://gutendex.com/books")!

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchBooks(nextPageURL: URL?) async throws -> BooksResponse {
        
        let url = nextPageURL ?? baseURL
        let (data, response) = try await session.data(from: url)

        guard let http = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard (200...299).contains(http.statusCode) else {
            throw APIError.httpStatus(http.statusCode)
        }

        do {
            return try JSONDecoder().decode(BooksResponse.self, from: data)
        } catch {
            throw APIError.decoding
        }
    }
}

//
//  APIError.swift
//  BooksApp
//
//  Created by Alex Provarenko on 12.02.2026.
//

import Foundation

enum APIError: Error, LocalizedError {
    
    case invalidURL
    case invalidResponse
    case httpStatus(Int)
    case decoding

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid server response."
        case .httpStatus(let code):
            return "Request failed with status code \(code)."
        case .decoding:
            return "Failed to decode response."
        }
    }
}


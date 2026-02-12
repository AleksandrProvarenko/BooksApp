//
//  NetworkServiceProtocol.swift
//  BooksApp
//
//  Created by Alex Provarenko on 12.02.2026.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchBooks(nextPageURL: URL?) async throws -> BooksResponse
}

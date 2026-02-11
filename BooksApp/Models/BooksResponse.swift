//
//  BooksResponse.swift
//  BooksApp
//
//  Created by Alex Provarenko on 11.02.2026.
//

import Foundation

struct BooksResponse: Decodable, Equatable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Book]
}

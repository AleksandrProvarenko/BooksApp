//
//  Person.swift
//  BooksApp
//
//  Created by Alex Provarenko on 11.02.2026.
//

import Foundation

struct Person: Decodable, Equatable {
    let name: String
    let birthYear: Int?
    let deathYear: Int?

    enum CodingKeys: String, CodingKey {
        case name
        case birthYear = "birth_year"
        case deathYear = "death_year"
    }
}

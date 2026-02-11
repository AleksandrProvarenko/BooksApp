//
//  Book.swift
//  BooksApp
//
//  Created by Alex Provarenko on 11.02.2026.
//

import Foundation

struct Book: Decodable, Identifiable, Equatable {
    let id: Int
    let title: String
    let subjects: [String]
    let authors: [Person]
    let summaries: [String]
    let languages: [String]
    let formats: [String: String]
    let downloadCount: Int

    enum CodingKeys: String, CodingKey {
        case id, title, subjects, authors, summaries, languages, formats
        case downloadCount = "download_count"
    }

    var authorDisplayName: String {
        authors.first?.name ?? "Unknown author"
    }

    var coverURL: URL? {
        if let urlString = formats["image/jpeg"] {
            return URL(string: urlString)
        }        
        return nil
    }

    var summaryText: String {
        summaries.first ?? "No summary available."
    }
}



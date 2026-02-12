//
//  FavoritesStore.swift
//  BooksApp
//
//  Created by Alex Provarenko on 12.02.2026.
//

import Foundation
import Combine

@MainActor
final class FavoritesStore: ObservableObject {
    
    @Published private(set) var favoritesById: [Int: Book] = [:]

    func isFavorite(_ book: Book) -> Bool {
        favoritesById[book.id] != nil
    }

    func toggle(_ book: Book) {
        if favoritesById[book.id] != nil {
            favoritesById.removeValue(forKey: book.id)
        } else {
            favoritesById[book.id] = book
        }
    }

    var favoriteBooks: [Book] {
        favoritesById.values.sorted { $0.title < $1.title }
    }
}

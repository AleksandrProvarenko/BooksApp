//
//  BookDetailsViewModel.swift
//  BooksApp
//
//  Created by Alex Provarenko on 12.02.2026.
//

import Foundation
import Combine

@MainActor
final class BookDetailsViewModel: ObservableObject {
    
    let book: Book
    private let favorites: FavoritesStore

    init(book: Book, favorites: FavoritesStore) {
        self.book = book
        self.favorites = favorites
    }

    var isFavorite: Bool {
        favorites.isFavorite(book)
    }

    func toggleFavorite() {
        favorites.toggle(book)
    }
}

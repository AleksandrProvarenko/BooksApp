//
//  FavoritesViewModel.swift
//  BooksApp
//
//  Created by Alex Provarenko on 12.02.2026.
//

import Foundation
import Combine

@MainActor
final class FavoritesViewModel: ObservableObject {
    
    @Published private(set) var books: [Book] = []

    private let store: FavoritesStore

    init(store: FavoritesStore) {
        self.store = store
        self.books = store.favoriteBooks
    }

    func refresh() {
        books = store.favoriteBooks
    }
}

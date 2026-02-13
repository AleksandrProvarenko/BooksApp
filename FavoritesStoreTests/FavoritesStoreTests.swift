//
//  FavoritesStoreTests.swift
//  FavoritesStoreTests
//
//  Created by Alex Provarenko on 13.02.2026.
//

import XCTest
@testable import BooksApp

final class FavoritesStoreTests: XCTestCase {

    func test_addsAndRemoves() async {
        await MainActor.run {
            let store = FavoritesStore()
            let book = Book(
                id: 10,
                title: "Fav",
                subjects: [],
                authors: [],
                summaries: [],
                languages: [],
                formats: [:],
                downloadCount: 0
            )

            XCTAssertFalse(store.isFavorite(book))
            store.toggle(book)
            XCTAssertTrue(store.isFavorite(book))
            XCTAssertEqual(store.favoriteBooks.count, 1)

            store.toggle(book)
            XCTAssertFalse(store.isFavorite(book))
            XCTAssertEqual(store.favoriteBooks.count, 0)
        }
    }
}

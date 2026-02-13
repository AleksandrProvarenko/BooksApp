//
//  BooksListViewModelTests.swift
//  BooksListViewModelTests
//
//  Created by Alex Provarenko on 13.02.2026.
//

import XCTest
@testable import BooksApp

@MainActor
final class BooksListViewModelTests: XCTestCase {
    
    func testLoadInitial_success_setsBooksAndLoaded() async {
        
        let mock = MockNetworkService()
        
        mock.result = .success(
            BooksResponse(
                count: 1,
                next: nil,
                previous: nil,
                results: [
                    Book(
                        id: 1,
                        title: "Test Book",
                        subjects: [],
                        authors: [Person(name: "Author", birthYear: nil, deathYear: nil)],
                        summaries: ["Summary"],
                        languages: ["en"],
                        formats: ["image/jpeg": "https://example.com/cover.jpg"],
                        downloadCount: 10
                    )
                ]
            )
        )
        
        let vm = BooksListViewModel(api: mock)
        await vm.loadInitial()
        
        XCTAssertEqual(vm.books.count, 1)
        XCTAssertEqual(vm.state, .loaded(vm.books))
        XCTAssertFalse(vm.canLoadMore)
    }
    
    func testLoadInitial_failure_setsError() async {
        let mock = MockNetworkService()
        mock.result = .failure(APIError.httpStatus(500))
        
        let vm = BooksListViewModel(api: mock)
        await vm.loadInitial()
        
        if case .error = vm.state {
            XCTAssertTrue(true)
        } else {
            XCTFail("Expected error state")
        }
    }
    
    func testPagination_appendsBooks() async {
        
        let mock = MockNetworkService()
        
        mock.result = .success(
            BooksResponse(
                count: 2,
                next: "https://gutendex.com/books/?page=2",
                previous: nil,
                results: [
                    Book(id: 1, title: "B1", subjects: [], authors: [], summaries: [], languages: [], formats: [:], downloadCount: 1)
                ]
            )
        )
        
        let vm = BooksListViewModel(api: mock)
        await vm.loadInitial()
        XCTAssertEqual(vm.books.map(\.id), [1])
        XCTAssertTrue(vm.canLoadMore)
        
        mock.result = .success(
            BooksResponse(
                count: 2,
                next: nil,
                previous: "https://gutendex.com/books/",
                results: [
                    Book(id: 2, title: "B2", subjects: [], authors: [], summaries: [], languages: [], formats: [:], downloadCount: 2)
                ]
            )
        )
        
        await vm.loadNextPage()
        XCTAssertEqual(vm.books.map(\.id), [1, 2])
        XCTAssertFalse(vm.canLoadMore)
    }
}

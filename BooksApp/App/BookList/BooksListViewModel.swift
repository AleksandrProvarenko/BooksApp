//
//  BooksListViewModel.swift
//  BooksApp
//
//  Created by Alex Provarenko on 12.02.2026.
//

import Foundation
import Combine

@MainActor
final class BooksListViewModel: ObservableObject {
    
    @Published private(set) var state: ViewState = .idle
    @Published private(set) var books: [Book] = []
    
    private let api: NetworkServiceProtocol
    private var nextURL: URL?
    
    init(api: NetworkServiceProtocol) {
        self.api = api
    }
    
    func loadInitial() async {
        if case .loading = state { return }
        state = .loading
        books = []
        nextURL = nil
        
        await loadNextPage()
    }
    
    func loadNextPage() async {
        
        if case .loading = state, !books.isEmpty {}
        
        do {
            
            if books.isEmpty {
                state = .loading
            }
            
            let response = try await api.fetchBooks(nextPageURL: nextURL)
            
            books.append(contentsOf: response.results)
            nextURL = response.next.flatMap { URL(string: $0) }
            state = .loaded(books)
        } catch {
            let message = (error as? LocalizedError)?.errorDescription ?? "Unknown error."
            state = .error(message)
        }
    }
    
    var canLoadMore: Bool {
        nextURL != nil
    }
}

//
//  BooksListView.swift
//  BooksApp
//
//  Created by Alex Provarenko on 11.02.2026.
//

import SwiftUI
import NukeUI

struct BooksListView: View {
    
    @StateObject var viewModel: BooksListViewModel
    @EnvironmentObject private var favorites: FavoritesStore
    
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                    
                case .idle:
                    ProgressView("Loading...")
                        .task { await viewModel.loadInitial() }
                case .loading:
                    ProgressView("Loading...")
                        .task { await viewModel.loadInitial() }
                case .error(let message):
                    VStack(spacing: 12) {
                        Text(message)
                            .multilineTextAlignment(.center)
                        
                        Button("Retry") {
                            Task { await viewModel.loadInitial() }
                        }
                    }
                    .padding()
                    
                case .loaded(let books):
                    List {
                        ForEach(books) { book in
                            NavigationLink {
                                BookDetailsView(book: book)
                                    .environmentObject(favorites)
                            } label: {
                                BookRow(book: book, isFavorite: favorites.isFavorite(book))
                            }
                        }
                        
                        if viewModel.canLoadMore {
                            HStack {
                                Spacer()
                                ProgressView()
                                    .task { await viewModel.loadNextPage() }
                                Spacer()
                            }
                        }
                    }
                }
            }
            .navigationTitle("Books")
        }
        .task {
            await viewModel.loadInitial()
        }
    }
}

private struct BookRow: View {
    
    let book: Book
    let isFavorite: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            
            LazyImage(url:book.coverURL)
                .frame(width: 48, height: 72)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(book.title)
                    .font(.headline)
                    .lineLimit(2)
                
                Text(book.authorDisplayName)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            if isFavorite {
                Image(systemName: "heart.fill")
                    .foregroundStyle(.red)
            }
        }
        .padding(.vertical, 4)
    }
}

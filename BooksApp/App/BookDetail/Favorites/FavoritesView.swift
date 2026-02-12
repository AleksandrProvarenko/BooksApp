//
//  FavoritesView.swift
//  BooksApp
//
//  Created by Alex Provarenko on 12.02.2026.
//

import SwiftUI
import NukeUI


struct FavoritesView: View {
    
    @StateObject var viewModel: FavoritesViewModel
    @EnvironmentObject private var favorites: FavoritesStore
    
    var body: some View {
        NavigationStack {
            
            Group {
                if viewModel.books.isEmpty {
                    Text("No favorites yet.")
                        .foregroundStyle(.secondary)
                } else {
                    List {
                        ForEach(viewModel.books) { book in
                            NavigationLink {
                                BookDetailsView(book: book)
                                    .environmentObject(favorites)
                            } label: {
                                FavoriteRow(book: book)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
            .onReceive(favorites.$favoritesById) { _ in
                viewModel.refresh()
            }
        }
    }
}

private struct FavoriteRow: View {
    
    let book: Book
    
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
                    .foregroundStyle(.secondary)
                
                Text("Downloads: \(book.downloadCount)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "heart.fill")
                .foregroundStyle(.red)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    let store = FavoritesStore()
    return FavoritesView(viewModel: .init(store: store))
        .environmentObject(store)
}

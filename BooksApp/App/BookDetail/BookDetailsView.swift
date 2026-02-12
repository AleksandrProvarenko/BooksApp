//
//  BookDetailsView.swift
//  BooksApp
//
//  Created by Alex Provarenko on 11.02.2026.
//

import SwiftUI
import NukeUI

struct BookDetailsView: View {
    
    let book: Book
    @EnvironmentObject private var favorites: FavoritesStore
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                HStack(alignment: .top, spacing: 12) {
                    LazyImage(url: book.coverURL)
                    .frame(width: 110, height: 160)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text(book.title)
                            .font(.title2)
                            .bold()
                        
                        Text(book.authorDisplayName)
                            .foregroundStyle(.secondary)
                        
                        Button {
                            favorites.toggle(book)
                        } label: {
                            Label(
                                favorites.isFavorite(book) ? "Unfavorite" : "Favorite",
                                systemImage: favorites.isFavorite(book) ? "heart.slash" : "heart"
                            )
                        }
                        .buttonStyle(.bordered)
                    }
                    
                    Spacer()
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Summary")
                        .font(.headline)
                    Text(book.summaryText)
                        .foregroundStyle(.primary)
                }
                
                if !book.subjects.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("Subjects")
                            .font(.headline)
                        ForEach(book.subjects.prefix(8), id: \.self) { item in
                            Text("• \(item)")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Downloads")
                        .font(.headline)
                    Text("\(book.downloadCount)")
                        .foregroundStyle(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    BookDetailsView(
        book: Book(
            id: 3,
            title: "Title",
            subjects: [],
            authors: [],
            summaries: [],
            languages: [],
            formats: [:],
            downloadCount: 3
        )
    )
    .environmentObject(FavoritesStore())
}

//
//  RootTabView.swift
//  BooksApp
//
//  Created by Alex Provarenko on 11.02.2026.
//

import SwiftUI

struct RootTabView: View {
    
    @EnvironmentObject private var favorites: FavoritesStore
    private let api = BooksAPIService()
    
    var body: some View {
        TabView {
            BooksListView(viewModel: BooksListViewModel(api: api))
                .environmentObject(favorites)
                .tabItem {
                    Label("Books", systemImage: "book")
                }
            
           FavoritesView(viewModel: FavoritesViewModel(store: favorites))
                .environmentObject(favorites)
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
        }
    }
}

#Preview {
    RootTabView()
}

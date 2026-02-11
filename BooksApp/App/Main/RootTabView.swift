//
//  RootTabView.swift
//  BooksApp
//
//  Created by Alex Provarenko on 11.02.2026.
//

import SwiftUI

struct RootTabView: View {
    
    var body: some View {
        TabView {
            BooksListView()
                .tabItem {
                    Label("Books", systemImage: "book")
                }
            
            BookDetailsView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
        }
    }
}

#Preview {
    RootTabView()
}

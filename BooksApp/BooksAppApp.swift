//
//  BooksAppApp.swift
//  BooksApp
//
//  Created by Alex Provarenko on 11.02.2026.
//

import SwiftUI

@main
struct BooksAppApp: App {
    
    @StateObject private var favorites = FavoritesStore()
    
    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(favorites)
        }
    }
}

//
//  WatchlistApp.swift
//  Watchlist
//
//  Created by Anish Agarwal on 2/6/25.
//

import SwiftUI
import SwiftData

@main
struct WatchlistApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Movie.self)
        }
    }
}

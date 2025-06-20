//
//  Movie.swift
//  Watchlist
//
//  Created by Anish Agarwal on 2/6/25.
//

import Foundation
import SwiftData

@Model

class Movie {
    var title: String
    var genre: Genre
    
    init(title: String, genre: Genre) {
        self.title = title
        self.genre = genre
    }
    
    @MainActor
    static var preview: ModelContainer {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(
            for: Movie.self,
            configurations: configuration
        )
        
        container.mainContext.insert(Movie(title: "John Wick", genre: Genre(rawValue: 1)!))
        container.mainContext.insert(Movie(title: "Groundhog Daw", genre: Genre(rawValue: 2)!))
        container.mainContext.insert(Movie(title: "Toy Story", genre: Genre(rawValue: 7)!))
        container.mainContext.insert(Movie(title: "Blade runner", genre: Genre(rawValue: 9)!))
        container.mainContext.insert(Movie(title: "Lord of the rings", genre: Genre(rawValue: 6)!))
        container.mainContext.insert(Movie(title: "Magnificent 7", genre: Genre(rawValue: 12)!))
        container.mainContext.insert(Movie(title: "The Revenant", genre: Genre(rawValue: 5)!))
        container.mainContext.insert(Movie(title: "Dirty dancing", genre: Genre(rawValue: 10)!))
        
        return container
    }
}

//
//  Genre.swift
//  Watchlist
//
//  Created by Anish Agarwal on 2/6/25.
//

import Foundation

enum Genre: Int, Codable, CaseIterable, Identifiable {
    /// Required by the identifiable protocol
    var id: Int {
        rawValue
    }
    
    case action = 1
    case comedy = 2
    case crime = 3
    case documentaty = 4
    case drama = 5
    case fanatasy = 6
    case kids = 7
    case musical = 8
    case scifi = 9
    case romance = 10
    case thriller = 11
    
    var name: String {
        switch self {
        case .action:
            "Action"
        case .comedy:
            "Comedy"
        case .crime:
            "Crime"
        case .documentaty:
            "Documentary"
        case .drama:
            "Drama"
        case .fanatasy:
            "Fantasy"
        case .kids:
            "Kids"
        case .musical:
            "Musical"
        case .scifi:
            "Sci-Fi"
        case .romance:
            "Romance"
        case .thriller:
            "Thriller"
        }
    }
    
}


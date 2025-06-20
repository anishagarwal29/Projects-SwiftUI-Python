//
//  PawsApp.swift
//  Paws
//
//  Created by Anish Agarwal on 1/6/25.
//

import SwiftUI
import SwiftData

@main
struct PawsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Pet.self)
        }
    }
}

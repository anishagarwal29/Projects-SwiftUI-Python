//
//  ContentView.swift
//  Watchlist
//
//  Created by Anish Agarwal on 2/6/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    // MARK: - Properties
    @Environment(\.modelContext) var modelContext
    @Query private var movies: [Movie]
    
    @State private var isSheetPresented: Bool = false
    @State private var randomMovie: String = ""
    @State private var isShowingAlert: Bool = false
    
    // MARK: - Functions
    
    private func randomMovieGenerator() {
        randomMovie = movies.randomElement()!.title
    }
    
    // MARK: - Body
    var body: some View {
        List {
            if !movies.isEmpty {
                Section(
                    header:
                        VStack {
                            Text("Watchlist")
                                .font(.largeTitle.weight(.black))
                                .foregroundStyle(.blue.gradient)
                                .padding()
                            
                            HStack{
                                Label("Title", systemImage: "movieclapper")
                                Spacer()
                                Label("Genre", systemImage: "tag")
                            }
                        }
                ) {
                    ForEach(movies) { movie in
                        HStack {
                            Text(movie.title)
                                .font(.title.weight(.light))
                                .padding(.vertical, 2)
                            
                            Spacer()
                            
                            Text(movie.genre.name)
                                .font(.footnote.weight(.medium))
                                .padding(.horizontal, 6)
                                .padding(.vertical, 3)
                                .background(
                                    Capsule()
                                        .stroke(lineWidth: 1)
                                )
                                .foregroundStyle(.tertiary)
                            
                        } // List row
                        .swipeActions {
                            Button(role: .destructive) {
                                modelContext.delete(movie)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    } //: FOR
                } //: Section
            } //: IF
        } //: LIST
        .overlay {
            if movies.isEmpty {
                EmptyListView()
            }
        } //: Overlay
        // MARK: - Safe Area
        .safeAreaInset(edge: .bottom, alignment: .center) {
            HStack {
                if movies.count <= 2 {
                    // Randomise button
                    Button {
                        randomMovieGenerator()
                        isShowingAlert = true
                    } label: {
                        ButtonImageView(symbolName: "arrow.trianglehead.2.clockwise.rotate.90.circle.fill")
                            
                    }
                    .alert(randomMovie, isPresented: $isShowingAlert) {
                        Button("OK", role: .cancel) {}
                    }
                    .accessibilityLabel("Random Movie")
                    .sensoryFeedback(.success, trigger: isShowingAlert)
                    
                    Spacer()
                }
                
                // New movie button
                Button {
                    isSheetPresented.toggle()
                } label: {
                    ButtonImageView(symbolName: "plus.circle.fill")
                }
                .accessibilityLabel("New Movie")
                .sensoryFeedback(.success, trigger: isSheetPresented)
            } //: HSTACK
            .padding(.horizontal)
        } //: Safe Area
        // MARK: - Sheet
        .sheet(isPresented: $isSheetPresented) {
            NewMovieFormView()
        }
    }
}

#Preview("Sample data") {
    ContentView()
        .modelContainer(Movie.preview)
}


// MARK: - Preview
#Preview("Empty list") {
    ContentView()
        .modelContainer(for: Movie.self, inMemory: true)
}

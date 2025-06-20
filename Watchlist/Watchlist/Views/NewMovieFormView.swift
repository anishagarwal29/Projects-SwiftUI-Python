//
//  NewMovieFormView.swift
//  Watchlist
//
//  Created by Anish Agarwal on 5/6/25.
//

import SwiftUI

struct NewMovieFormView: View {
    // MARK: - Properties
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    
    @State private var title: String = ""
    @State private var selectedGenre: Genre = .kids
    
    // MARK: - Functons
    
    private func addNewMovie() {
        let newMovie = Movie(title: title, genre: selectedGenre)
        modelContext.insert(newMovie)
        title = ""
        selectedGenre = .kids
    }
    
    // MARK: - Body
    var body: some View {
        Form {
            List {
                // MARK: - Header
                Text("What to Watch")
                    .font(.largeTitle.weight(.black))
                    .foregroundStyle(.blue.gradient)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    .padding(.vertical)
                
                
                // MARK: - Title
                TextField("Movie Title", text: $title)
                    .textFieldStyle(.roundedBorder)
                    .font(.largeTitle.weight(.light))
                
                // MARK: - Genre
                Picker("Genre", selection: $selectedGenre) {
                    ForEach(Genre.allCases) { genre in
                        Text(genre.name)
                            .tag(genre)
                    }
                }
                
                // MARK: - Save button
                Button {
                    if title.isEmpty || title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                       
                        return
                    } else {
                        addNewMovie()
                        dismiss()
                    }
                } label: {
                    Text("Save")
                        .font(.title2.weight(.medium))
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.extraLarge)
                .buttonBorderShape(.roundedRectangle)
                .disabled(title.isEmpty || title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                
                // MARK: - Cancel button
                Button {
                    dismiss()
                } label: {
                    Text("Close")
                        .frame(maxWidth: .infinity)
                }
                
            } //: List
            .listRowSeparator(.hidden)
        } //: Form
    }
}

// MARK: - Preview
#Preview {
    NewMovieFormView()
}

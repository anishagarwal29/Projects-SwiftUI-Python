//
//  EditPetView.swift
//  Paws
//
//  Created by Anish Agarwal on 2/6/25.
//

import SwiftUI
import SwiftData
import PhotosUI

struct EditPetView: View {
    // MARK: - Properties
    @Environment(\.dismiss) private var dismiss
    @Bindable var pet: Pet
    @State private var photosPickerItem: PhotosPickerItem?
    
    // MARK: - Body
    var body: some View {
        Form {
            // MARK: - Image
            if let imageData = pet.photo {
                if let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 300)
                        .padding(.top)
                        .shadow(color: .gray, radius: 5)
                }
            } else {
                CustomContentUnavailableView(
                    icon: "pawprint.circle",
                    title: "No Photo",
                    description: "Add a photo of your favourite pet to make it easier to find them"
                )
                .padding(.top)
            }
            
            
            // MARK: - Photo picker
            PhotosPicker(selection: $photosPickerItem, matching: .images) {
                Label("Select a photo", systemImage: "photo.badge.plus")
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .listRowSeparator(.hidden)
            
            
            // MARK: - Text field
            TextField("Name", text: $pet.name)
                .textFieldStyle(.roundedBorder)
                .font(.largeTitle.weight(.light))
                .padding(.vertical)
            
            
            // MARK: - Button
            Button {
                dismiss()
            } label: {
                Text("Save")
                    .font(.title3.weight(.medium))
                    .padding(8)
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .listRowSeparator(.hidden)
            .padding(.bottom)
            
            
        } //: Form
        .listStyle(.plain)
        .navigationTitle("Edit \(pet.name)")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .onChange(of: photosPickerItem) {
            Task {
                pet.photo = try? await photosPickerItem?.loadTransferable(type: Data.self)
            } //: TASK
        } //: ONChange
        
    }
}

// MARK: - Previews
#Preview {
    NavigationStack {
        do {
            let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Pet.self, configurations: configuration)
            let sampleData = Pet(name: "Daisy")
            
            return EditPetView(pet: sampleData)
                .modelContainer(container)
        } catch {
            fatalError("Could not load preview data. \(error.localizedDescription)")
        }
    }
}

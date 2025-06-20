//
//  EditItemView.swift
//  ClientExpenseTracker
//
//  Created by Anish Agarwal on 20/6/25.
//

import SwiftUI

struct EditItemView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    @Bindable var purchase: Purchase
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Edit Details")) {
                    TextField("Person's Name", text: $purchase.name)
                    TextField("Amount Spent", text: Binding(
                        get: { String(format: "%.2f", purchase.amount) },
                        set: { purchase.amount = Double($0) ?? purchase.amount }
                    ))
                    .keyboardType(.decimalPad)
                    DatePicker("Date", selection: $purchase.date, displayedComponents: .date)
                }
            }
            .navigationTitle("Edit Purchase")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveContext()
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}

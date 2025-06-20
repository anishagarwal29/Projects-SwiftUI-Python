//
//  AddItemView.swift
//  ClientExpenseTracker
//
//  Created by Anish Agarwal on 20/6/25.
//

import SwiftUI

struct AddItemView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    @State private var name: String = ""
    @State private var amount: String = ""
    @State private var date: Date = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Details")) {
                    TextField("Person's Name", text: $name)
                    TextField("Amount Spent", text: $amount)
                        .keyboardType(.decimalPad)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }
            }
            .navigationTitle("New Purchase")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let amountDouble = Double(amount) {
                            let newPurchase = Purchase(name: name, amount: amountDouble, date: date)
                            context.insert(newPurchase)
                            saveContext()
                            dismiss()
                        }
                    }
                    .disabled(name.isEmpty || amount.isEmpty)
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

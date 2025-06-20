import SwiftUI
import SwiftData

// MARK: - Model
@Model
final class Purchase {
    @Attribute(.unique) var id: UUID
    var name: String
    var amount: Double
    var date: Date

    init(name: String, amount: Double, date: Date) {
        self.id = UUID()
        self.name = name
        self.amount = amount
        self.date = date
    }
}

// MARK: - ContentView
struct ContentView: View {
    // MARK: - Properties
    @Query private var purchases: [Purchase]
    @Environment(\.modelContext) private var context
    @State private var isAddingPurchase = false
    @State private var isEditingPurchase = false
    @State private var selectedPurchase: Purchase?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(purchases) { purchase in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(purchase.name)
                                .font(.headline)
                            Text(purchase.date, style: .date)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Text("$\(purchase.amount, specifier: "%.2f")")
                            .font(.headline)
                    }
                    .swipeActions {
                        // Delete Action
                        Button(role: .destructive) {
                            deletePurchase(purchase: purchase)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        
                        // Copy Action
                        Button {
                            copyPurchase(purchase: purchase)
                        } label: {
                            Label("Copy", systemImage: "doc.on.doc")
                        }
                        .tint(.blue) // Customize color for the copy button
                    }
                    .onTapGesture {
                        selectedPurchase = purchase
                        isEditingPurchase = true
                    }
                }
//                .onDelete(perform: deletePurchase)
            }
            .navigationTitle("Client Purchases")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isAddingPurchase = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingPurchase) {
                AddItemView()
            }
            .sheet(isPresented: $isEditingPurchase) {
                if let selectedPurchase = selectedPurchase {
                    EditItemView(purchase: selectedPurchase)
                }
            }
        }
    }
    
    // MARK: - Methods
    private func deletePurchase(purchase: Purchase) {
        context.delete(purchase)
        try? context.save() // Handle any errors
    }
    
    private func copyPurchase(purchase: Purchase) {
        let copiedPurchase = Purchase(name: purchase.name, amount: purchase.amount, date: purchase.date)
        context.insert(copiedPurchase)
        try? context.save() // Handle any errors
    }

    
    // MARK: - Preview
    @main
    struct ClientExpenseTrackerApp: App {
        var body: some Scene {
            WindowGroup {
                ContentView()
                    .modelContainer(for: Purchase.self) // SwiftData container
            }
        }
    }
}

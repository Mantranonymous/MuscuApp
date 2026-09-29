import SwiftUI

/// Stub Sprint 3. Panier MyProtein mensuel pré-rempli avec checkboxes.
struct ShoppingListView: View {
    var body: some View {
        ContentUnavailableView(
            "Liste de courses",
            systemImage: "cart.fill",
            description: Text("Disponible au Sprint 3 — panier MyProtein mensuel à cocher.")
        )
        .navigationTitle("Courses")
    }
}

#Preview {
    NavigationStack { ShoppingListView() }
        .preferredColorScheme(.dark)
}

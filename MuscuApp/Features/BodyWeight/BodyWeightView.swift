import SwiftUI

/// Stub Sprint 3. Saisie pesées + graphique hebdo + indicateur OK/lent/rapide.
struct BodyWeightView: View {
    var body: some View {
        ContentUnavailableView(
            "Suivi du poids",
            systemImage: "scalemass.fill",
            description: Text("Disponible au Sprint 3 — graphique hebdo + indicateur progression.")
        )
        .navigationTitle("Poids")
    }
}

#Preview {
    NavigationStack { BodyWeightView() }
        .preferredColorScheme(.dark)
}

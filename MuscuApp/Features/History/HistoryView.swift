import SwiftUI

/// Stub Sprint 3. Affichera la liste des sessions terminées et le détail par exercice.
struct HistoryView: View {
    var body: some View {
        ContentUnavailableView(
            "Historique",
            systemImage: "list.bullet.rectangle.portrait",
            description: Text("Disponible au Sprint 3 — liste des séances passées et progression par exercice.")
        )
        .navigationTitle("Historique")
    }
}

#Preview {
    NavigationStack { HistoryView() }
        .preferredColorScheme(.dark)
}

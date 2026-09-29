import SwiftUI

/// Stub Sprint 2. Saisie en temps réel des séries + timer de repos + timer global 55 min.
struct WorkoutSessionView: View {
    var body: some View {
        ContentUnavailableView(
            "Séance en cours",
            systemImage: "dumbbell.fill",
            description: Text("Disponible au Sprint 2 — saisie poids/reps, timer repos et timer 55 min.")
        )
    }
}

#Preview {
    WorkoutSessionView()
        .preferredColorScheme(.dark)
}

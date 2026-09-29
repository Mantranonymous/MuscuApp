import Foundation
import SwiftData

/// Une série effectuée (1 set = 1 ligne).
@Model
final class ExerciseSet {
    @Attribute(.unique) var id: UUID
    /// Référence à l'Exercise du catalogue (par UUID — pas de relation forte volontairement,
    /// pour pouvoir renommer/réorganiser le catalogue sans casser l'historique).
    var exerciseId: UUID
    /// Snapshot du nom de l'exercice au moment de la série (résilience à un rename).
    var exerciseName: String
    var weightKg: Double
    var reps: Int
    /// Numéro de série dans la séance (1, 2, 3...).
    var setNumber: Int
    var completedAt: Date

    /// Lien inverse vers la session (set par @Relationship sur WorkoutSession.sets).
    var session: WorkoutSession?

    init(
        id: UUID = UUID(),
        exerciseId: UUID,
        exerciseName: String,
        weightKg: Double,
        reps: Int,
        setNumber: Int,
        completedAt: Date = Date()
    ) {
        self.id = id
        self.exerciseId = exerciseId
        self.exerciseName = exerciseName
        self.weightKg = weightKg
        self.reps = reps
        self.setNumber = setNumber
        self.completedAt = completedAt
    }
}

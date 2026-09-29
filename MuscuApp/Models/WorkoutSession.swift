import Foundation
import SwiftData

/// Une séance effectuée (instance, pas le template).
@Model
final class WorkoutSession {
    @Attribute(.unique) var id: UUID
    var startedAt: Date
    /// Nil si la séance est en cours.
    var endedAt: Date?
    var workoutTypeRaw: String
    /// Notes libres (optionnel, V2).
    var notes: String?

    /// Toutes les séries effectuées dans cette séance.
    /// Cascade : supprimer une session supprime ses sets.
    @Relationship(deleteRule: .cascade, inverse: \ExerciseSet.session)
    var sets: [ExerciseSet] = []

    var workoutType: WorkoutType {
        WorkoutType(rawValue: workoutTypeRaw) ?? .a
    }

    /// Durée effective (depuis le début, ou jusqu'à endedAt si terminée).
    var duration: TimeInterval {
        (endedAt ?? Date()).timeIntervalSince(startedAt)
    }

    var isCompleted: Bool { endedAt != nil }

    init(
        id: UUID = UUID(),
        startedAt: Date = Date(),
        workoutType: WorkoutType
    ) {
        self.id = id
        self.startedAt = startedAt
        self.workoutTypeRaw = workoutType.rawValue
    }
}

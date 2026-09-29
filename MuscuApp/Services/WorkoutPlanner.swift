import Foundation
import SwiftData

/// Détermine quelle séance proposer aujourd'hui, en rotation libre A → B → C.
///
/// Règles :
/// - Si aucune session passée   → A
/// - Sinon                       → la séance qui suit la dernière effectuée
/// - Si une session a déjà été terminée aujourd'hui → on l'indique (cas "déjà fait")
enum WorkoutPlanner {

    struct Suggestion {
        let next: WorkoutType
        /// Vrai si une séance a déjà été terminée aujourd'hui (l'utilisateur peut quand même en relancer une).
        let alreadyTrainedToday: Bool
    }

    static func suggest(in context: ModelContext, now: Date = Date()) -> Suggestion {
        var descriptor = FetchDescriptor<WorkoutSession>(
            predicate: #Predicate { $0.endedAt != nil },
            sortBy: [SortDescriptor(\.endedAt, order: .reverse)]
        )
        descriptor.fetchLimit = 1

        let last = (try? context.fetch(descriptor))?.first

        let next: WorkoutType
        let trainedToday: Bool

        if let last, let endedAt = last.endedAt {
            next = last.workoutType.next
            trainedToday = Calendar.current.isDate(endedAt, inSameDayAs: now)
        } else {
            next = .a
            trainedToday = false
        }

        return Suggestion(next: next, alreadyTrainedToday: trainedToday)
    }

    /// Récupère tous les exercices d'une séance donnée, triés par ordre.
    static func exercises(for type: WorkoutType, in context: ModelContext) -> [Exercise] {
        let raw = type.rawValue
        let descriptor = FetchDescriptor<Exercise>(
            predicate: #Predicate { $0.workoutTypeRaw == raw },
            sortBy: [SortDescriptor(\.order)]
        )
        return (try? context.fetch(descriptor)) ?? []
    }
}

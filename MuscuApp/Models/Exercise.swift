import Foundation
import SwiftData

/// Type de séance dans la rotation A → B → C.
enum WorkoutType: String, Codable, CaseIterable, Identifiable {
    case a = "A"   // Push : Pecs / Épaules / Triceps
    case b = "B"   // Pull : Dos / Biceps / Abdos
    case c = "C"   // Pecs + Bras + Épaules + Jambes machines

    var id: String { rawValue }

    var title: String {
        switch self {
        case .a: "Séance A — Push"
        case .b: "Séance B — Pull"
        case .c: "Séance C — Pecs+Bras+Jambes"
        }
    }

    /// Séance qui suit dans la rotation.
    var next: WorkoutType {
        switch self {
        case .a: .b
        case .b: .c
        case .c: .a
        }
    }
}

/// Un exercice dans le programme. Catalogue immuable (alimenté par SeedData au 1er lancement).
@Model
final class Exercise {
    @Attribute(.unique) var id: UUID
    var name: String
    /// Fourchette de reps cible (ex. 8-10).
    var repsMin: Int
    var repsMax: Int
    /// Repos entre séries en secondes.
    var restSec: Int
    /// Nombre de séries cible.
    var setsTarget: Int
    /// "A", "B", "C" — stocké en String car SwiftData ne supporte pas (encore) les enums RawRepresentable directement dans toutes les versions.
    var workoutTypeRaw: String
    /// Ordre dans la séance (1-based).
    var order: Int
    /// Si vrai : exercice optionnel (à faire si le timing le permet).
    var isOptional: Bool

    var workoutType: WorkoutType {
        WorkoutType(rawValue: workoutTypeRaw) ?? .a
    }

    var repsRangeLabel: String {
        repsMin == repsMax ? "\(repsMin)" : "\(repsMin)-\(repsMax)"
    }

    init(
        id: UUID = UUID(),
        name: String,
        repsMin: Int,
        repsMax: Int,
        restSec: Int,
        setsTarget: Int,
        workoutType: WorkoutType,
        order: Int,
        isOptional: Bool = false
    ) {
        self.id = id
        self.name = name
        self.repsMin = repsMin
        self.repsMax = repsMax
        self.restSec = restSec
        self.setsTarget = setsTarget
        self.workoutTypeRaw = workoutType.rawValue
        self.order = order
        self.isOptional = isOptional
    }
}

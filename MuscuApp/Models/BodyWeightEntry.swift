import Foundation
import SwiftData

/// Une pesée corporelle.
@Model
final class BodyWeightEntry {
    @Attribute(.unique) var id: UUID
    var date: Date
    var weightKg: Double
    var note: String?

    init(
        id: UUID = UUID(),
        date: Date = Date(),
        weightKg: Double,
        note: String? = nil
    ) {
        self.id = id
        self.date = date
        self.weightKg = weightKg
        self.note = note
    }
}

import Foundation
import SwiftData

enum SupplementKind: String, Codable, CaseIterable, Identifiable {
    case creatine
    case alphaMen = "alpha_men"
    case omega3 = "omega3"

    var id: String { rawValue }

    var title: String {
        switch self {
        case .creatine: "Créatine (5 g)"
        case .alphaMen: "Alpha Men (2 cps)"
        case .omega3: "Oméga-3"
        }
    }

    var icon: String {
        switch self {
        case .creatine: "drop.fill"
        case .alphaMen: "pills.fill"
        case .omega3: "fish.fill"
        }
    }
}

/// Trace de prise d'un complément (1 log = 1 prise dans la journée).
@Model
final class SupplementLog {
    @Attribute(.unique) var id: UUID
    var date: Date
    var kindRaw: String

    var kind: SupplementKind {
        SupplementKind(rawValue: kindRaw) ?? .creatine
    }

    init(
        id: UUID = UUID(),
        date: Date = Date(),
        kind: SupplementKind
    ) {
        self.id = id
        self.date = date
        self.kindRaw = kind.rawValue
    }
}

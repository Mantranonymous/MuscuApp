import Foundation
import SwiftData

enum ShakerKind: String, Codable, CaseIterable, Identifiable {
    case avoineCacahuete = "avoine_cacahuete"
    case yaourtBuvable = "yaourt_buvable"

    var id: String { rawValue }

    var title: String {
        switch self {
        case .avoineCacahuete: "Shaker avoine / cacahuète"
        case .yaourtBuvable: "Shaker yaourt à boire"
        }
    }

    var shortTitle: String {
        switch self {
        case .avoineCacahuete: "Avoine / cacahuète"
        case .yaourtBuvable: "Yaourt buvable"
        }
    }
}

/// Trace d'un shaker pris (pour suivre l'apport calorique et la régularité).
@Model
final class ShakerLog {
    @Attribute(.unique) var id: UUID
    var date: Date
    var kindRaw: String

    var kind: ShakerKind {
        ShakerKind(rawValue: kindRaw) ?? .avoineCacahuete
    }

    init(
        id: UUID = UUID(),
        date: Date = Date(),
        kind: ShakerKind
    ) {
        self.id = id
        self.date = date
        self.kindRaw = kind.rawValue
    }
}

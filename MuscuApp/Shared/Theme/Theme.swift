import SwiftUI

/// Palette et tokens UI. Mode sombre par défaut.
enum Theme {

    // MARK: - Couleurs
    enum Colors {
        static let background = Color(.systemBackground)
        static let surface = Color(.secondarySystemBackground)
        static let surfaceElevated = Color(.tertiarySystemBackground)
        static let accent = Color.orange         // accent énergique
        static let success = Color.green
        static let warning = Color.yellow
        static let danger = Color.red
        static let textPrimary = Color.primary
        static let textSecondary = Color.secondary
    }

    // MARK: - Espacements
    enum Spacing {
        static let xs: CGFloat = 4
        static let s: CGFloat = 8
        static let m: CGFloat = 16
        static let l: CGFloat = 24
        static let xl: CGFloat = 32
    }

    // MARK: - Radius
    enum Radius {
        static let s: CGFloat = 8
        static let m: CGFloat = 12
        static let l: CGFloat = 16
    }

    // MARK: - Tailles "salle" (gros boutons utilisables avec doigts moites)
    enum Sizes {
        static let buttonHeight: CGFloat = 56
        static let tapMinSide: CGFloat = 44
    }
}

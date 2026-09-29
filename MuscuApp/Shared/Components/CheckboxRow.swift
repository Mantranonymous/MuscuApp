import SwiftUI

/// Ligne checkable réutilisable (compléments, ingrédients, liste de courses).
/// Surface tactile généreuse (hauteur 48pt min) pour usage en salle.
struct CheckboxRow: View {
    let title: String
    let subtitle: String?
    let systemImage: String?
    let isChecked: Bool
    let onToggle: () -> Void

    init(
        title: String,
        subtitle: String? = nil,
        systemImage: String? = nil,
        isChecked: Bool,
        onToggle: @escaping () -> Void
    ) {
        self.title = title
        self.subtitle = subtitle
        self.systemImage = systemImage
        self.isChecked = isChecked
        self.onToggle = onToggle
    }

    var body: some View {
        Button(action: {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            onToggle()
        }) {
            HStack(spacing: Theme.Spacing.m) {
                Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(isChecked ? Theme.Colors.success : Theme.Colors.textSecondary)

                if let systemImage {
                    Image(systemName: systemImage)
                        .foregroundStyle(Theme.Colors.textSecondary)
                        .frame(width: 20)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.body)
                        .foregroundStyle(Theme.Colors.textPrimary)
                        .strikethrough(isChecked, color: Theme.Colors.textSecondary)
                    if let subtitle {
                        Text(subtitle)
                            .font(.caption)
                            .foregroundStyle(Theme.Colors.textSecondary)
                    }
                }
                Spacer(minLength: 0)
            }
            .frame(minHeight: 48)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

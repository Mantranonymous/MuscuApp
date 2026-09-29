import SwiftUI

/// Carte regroupant un titre et un contenu. Utilisée sur l'écran Aujourd'hui.
struct SectionCard<Content: View>: View {
    let title: String
    let systemImage: String?
    let content: Content

    init(
        title: String,
        systemImage: String? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.systemImage = systemImage
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.m) {
            HStack(spacing: Theme.Spacing.s) {
                if let systemImage {
                    Image(systemName: systemImage)
                        .foregroundStyle(Theme.Colors.accent)
                        .imageScale(.medium)
                }
                Text(title)
                    .font(.headline)
                Spacer(minLength: 0)
            }
            content
        }
        .padding(Theme.Spacing.m)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.Colors.surface)
        .clipShape(RoundedRectangle(cornerRadius: Theme.Radius.l))
    }
}

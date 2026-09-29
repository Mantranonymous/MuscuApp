import SwiftUI

/// Recettes shaker en lecture seule. Logging des shakers du jour fait sur l'écran Aujourd'hui.
struct ShakersView: View {

    var body: some View {
        ScrollView {
            VStack(spacing: Theme.Spacing.m) {
                shakerCard(
                    title: "Shaker avoine / cacahuète",
                    subtitle: "Prise de masse",
                    ingredients: [
                        "30 g whey (vanille ou chocolat)",
                        "70 g flocons d'avoine fins",
                        "15 g beurre de cacahuète",
                        "250 ml lait",
                        "5 g créatine"
                    ]
                )

                shakerCard(
                    title: "Shaker yaourt à boire",
                    subtitle: "Plus digeste",
                    ingredients: [
                        "30 g whey (neutre ou vanille)",
                        "1 yaourt à boire / skyr liquide (200 ml)",
                        "40-60 g avoine fine",
                        "1 c.à.s huile colza/olive",
                        "5 g créatine"
                    ]
                )

                SectionCard(title: "Cible nutritionnelle", systemImage: "target") {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("≈ 2 800 – 3 000 kcal / jour")
                        Text("≈ 130 – 140 g de protéines / jour")
                    }
                    .font(.subheadline)
                    .foregroundStyle(Theme.Colors.textSecondary)
                }
            }
            .padding(Theme.Spacing.m)
        }
        .navigationTitle("Shakers")
        .background(Theme.Colors.background)
    }

    private func shakerCard(title: String, subtitle: String, ingredients: [String]) -> some View {
        SectionCard(title: title, systemImage: "cup.and.saucer.fill") {
            VStack(alignment: .leading, spacing: Theme.Spacing.s) {
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(Theme.Colors.accent)
                ForEach(ingredients, id: \.self) { ing in
                    HStack(alignment: .top, spacing: 8) {
                        Text("•").foregroundStyle(Theme.Colors.textSecondary)
                        Text(ing)
                            .font(.subheadline)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack { ShakersView() }
        .preferredColorScheme(.dark)
}

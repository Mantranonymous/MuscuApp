import SwiftUI
import SwiftData

/// Écran "Aujourd'hui" — vue d'ensemble de la journée :
/// 1. Séance proposée (rotation A→B→C) avec bouton "Démarrer".
/// 2. Routine horaire type (jour d'entraînement).
/// 3. Compléments du jour à cocher.
/// 4. Shakers du jour à cocher.
struct TodayView: View {

    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = TodayViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: Theme.Spacing.m) {
                workoutCard
                supplementsCard
                shakersCard
                routineCard
            }
            .padding(Theme.Spacing.m)
        }
        .navigationTitle(headerTitle)
        .navigationBarTitleDisplayMode(.large)
        .background(Theme.Colors.background)
        .onAppear {
            viewModel.reload(context: modelContext)
        }
    }

    // MARK: - Header

    private var headerTitle: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "EEEE d MMMM"
        return formatter.string(from: Date()).capitalized
    }

    // MARK: - Sections

    private var workoutCard: some View {
        SectionCard(title: "Séance du jour", systemImage: "dumbbell.fill") {
            VStack(alignment: .leading, spacing: Theme.Spacing.m) {

                if viewModel.suggestion.alreadyTrainedToday {
                    Label("Tu as déjà fait une séance aujourd'hui", systemImage: "checkmark.seal.fill")
                        .font(.subheadline)
                        .foregroundStyle(Theme.Colors.success)
                }

                Text(viewModel.suggestion.next.title)
                    .font(.title2.bold())

                if !viewModel.todayExercises.isEmpty {
                    VStack(alignment: .leading, spacing: 6) {
                        ForEach(viewModel.todayExercises) { ex in
                            HStack(spacing: 8) {
                                Text("\(ex.order).")
                                    .foregroundStyle(Theme.Colors.textSecondary)
                                    .frame(width: 22, alignment: .trailing)
                                Text(ex.name)
                                    .foregroundStyle(
                                        ex.isOptional ? Theme.Colors.textSecondary : Theme.Colors.textPrimary
                                    )
                                if ex.isOptional {
                                    Text("(opt.)")
                                        .font(.caption2)
                                        .foregroundStyle(Theme.Colors.textSecondary)
                                }
                                Spacer(minLength: 0)
                                Text("\(ex.setsTarget)×\(ex.repsRangeLabel)")
                                    .font(.caption.monospacedDigit())
                                    .foregroundStyle(Theme.Colors.textSecondary)
                            }
                            .font(.subheadline)
                        }
                    }
                    .padding(.top, 4)
                }

                Button {
                    // Sprint 2 : push WorkoutSessionView
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                } label: {
                    HStack {
                        Image(systemName: "play.fill")
                        Text("Démarrer la séance")
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity, minHeight: Theme.Sizes.buttonHeight)
                }
                .buttonStyle(.borderedProminent)
                .tint(Theme.Colors.accent)
            }
        }
    }

    private var supplementsCard: some View {
        SectionCard(title: "Compléments du jour", systemImage: "pills.fill") {
            VStack(spacing: 4) {
                ForEach(SupplementKind.allCases) { kind in
                    CheckboxRow(
                        title: kind.title,
                        systemImage: kind.icon,
                        isChecked: viewModel.todaySupplements.contains(kind)
                    ) {
                        viewModel.toggleSupplement(kind, context: modelContext)
                    }
                }
            }
        }
    }

    private var shakersCard: some View {
        SectionCard(title: "Shakers", systemImage: "cup.and.saucer.fill") {
            VStack(spacing: 4) {
                ForEach(ShakerKind.allCases) { kind in
                    CheckboxRow(
                        title: kind.title,
                        isChecked: viewModel.todayShakers.contains(kind)
                    ) {
                        viewModel.toggleShaker(kind, context: modelContext)
                    }
                }
            }
        }
    }

    private var routineCard: some View {
        SectionCard(title: "Routine type", systemImage: "clock.fill") {
            VStack(alignment: .leading, spacing: Theme.Spacing.s) {
                routineLine("08:00", "Réveil · eau · créatine · Alpha Men · Oméga-3")
                routineLine("08:25", "Départ salle (5 min à pied)")
                routineLine("08:30", "Début séance")
                routineLine("09:25", "Fin séance + retour")
                routineLine("09:30", "Préparation shaker · douche")
                routineLine("09:40", "Boire le shaker en s'habillant")
                routineLine("09:45", "Départ travail")
            }
        }
    }

    private func routineLine(_ hour: String, _ text: String) -> some View {
        HStack(alignment: .top, spacing: Theme.Spacing.m) {
            Text(hour)
                .font(.subheadline.monospacedDigit().weight(.semibold))
                .foregroundStyle(Theme.Colors.accent)
                .frame(width: 50, alignment: .leading)
            Text(text)
                .font(.subheadline)
                .foregroundStyle(Theme.Colors.textPrimary)
            Spacer(minLength: 0)
        }
    }
}

#Preview {
    NavigationStack {
        TodayView()
    }
    .modelContainer(for: [
        Exercise.self, WorkoutSession.self, ExerciseSet.self,
        BodyWeightEntry.self, ShakerLog.self, SupplementLog.self
    ], inMemory: true)
    .preferredColorScheme(.dark)
}

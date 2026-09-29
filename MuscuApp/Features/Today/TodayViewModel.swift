import Foundation
import SwiftData
import Observation

/// ViewModel de l'écran Aujourd'hui.
/// Annoté `@Observable` (iOS 17+) → SwiftUI observe automatiquement les changements
/// sans devoir publier explicitement chaque propriété.
@Observable
final class TodayViewModel {

    /// Type de la séance suggérée pour aujourd'hui.
    var suggestion: WorkoutPlanner.Suggestion = .init(next: .a, alreadyTrainedToday: false)

    /// Exercices de la séance proposée (pour aperçu).
    var todayExercises: [Exercise] = []

    /// Logs du jour pour les compléments (pour cocher/décocher).
    var todaySupplements: Set<SupplementKind> = []

    /// Logs du jour pour les shakers.
    var todayShakers: Set<ShakerKind> = []

    // MARK: - Chargement

    func reload(context: ModelContext, now: Date = Date()) {
        suggestion = WorkoutPlanner.suggest(in: context, now: now)
        todayExercises = WorkoutPlanner.exercises(for: suggestion.next, in: context)
        todaySupplements = fetchTodaySupplements(context: context, now: now)
        todayShakers = fetchTodayShakers(context: context, now: now)
    }

    // MARK: - Toggle compléments / shakers

    func toggleSupplement(_ kind: SupplementKind, context: ModelContext, now: Date = Date()) {
        if todaySupplements.contains(kind) {
            // Décocher → supprimer le log du jour
            if let existing = findSupplementLog(kind: kind, context: context, now: now) {
                context.delete(existing)
            }
            todaySupplements.remove(kind)
        } else {
            let log = SupplementLog(date: now, kind: kind)
            context.insert(log)
            todaySupplements.insert(kind)
        }
        try? context.save()
    }

    func toggleShaker(_ kind: ShakerKind, context: ModelContext, now: Date = Date()) {
        if todayShakers.contains(kind) {
            if let existing = findShakerLog(kind: kind, context: context, now: now) {
                context.delete(existing)
            }
            todayShakers.remove(kind)
        } else {
            let log = ShakerLog(date: now, kind: kind)
            context.insert(log)
            todayShakers.insert(kind)
        }
        try? context.save()
    }

    // MARK: - Helpers privés

    private func fetchTodaySupplements(context: ModelContext, now: Date) -> Set<SupplementKind> {
        let (start, end) = dayBounds(for: now)
        let descriptor = FetchDescriptor<SupplementLog>(
            predicate: #Predicate { $0.date >= start && $0.date < end }
        )
        let logs = (try? context.fetch(descriptor)) ?? []
        return Set(logs.map { $0.kind })
    }

    private func fetchTodayShakers(context: ModelContext, now: Date) -> Set<ShakerKind> {
        let (start, end) = dayBounds(for: now)
        let descriptor = FetchDescriptor<ShakerLog>(
            predicate: #Predicate { $0.date >= start && $0.date < end }
        )
        let logs = (try? context.fetch(descriptor)) ?? []
        return Set(logs.map { $0.kind })
    }

    private func findSupplementLog(kind: SupplementKind, context: ModelContext, now: Date) -> SupplementLog? {
        let (start, end) = dayBounds(for: now)
        let raw = kind.rawValue
        let descriptor = FetchDescriptor<SupplementLog>(
            predicate: #Predicate { $0.kindRaw == raw && $0.date >= start && $0.date < end }
        )
        return (try? context.fetch(descriptor))?.first
    }

    private func findShakerLog(kind: ShakerKind, context: ModelContext, now: Date) -> ShakerLog? {
        let (start, end) = dayBounds(for: now)
        let raw = kind.rawValue
        let descriptor = FetchDescriptor<ShakerLog>(
            predicate: #Predicate { $0.kindRaw == raw && $0.date >= start && $0.date < end }
        )
        return (try? context.fetch(descriptor))?.first
    }

    /// Bornes du jour [00:00, lendemain 00:00[.
    private func dayBounds(for date: Date) -> (Date, Date) {
        let cal = Calendar.current
        let start = cal.startOfDay(for: date)
        let end = cal.date(byAdding: .day, value: 1, to: start) ?? start
        return (start, end)
    }
}

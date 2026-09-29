import Foundation
import SwiftData

/// Insère le catalogue d'exercices au premier lancement.
/// Idempotent : ne fait rien si des exercices existent déjà.
enum SeedData {

    static func seedIfNeeded(_ context: ModelContext) {
        let descriptor = FetchDescriptor<Exercise>()
        let existing = (try? context.fetchCount(descriptor)) ?? 0
        guard existing == 0 else { return }

        let exercises = allExercises()
        for ex in exercises {
            context.insert(ex)
        }

        do {
            try context.save()
        } catch {
            print("Seed failed: \(error)")
        }
    }

    /// Liste complète des exos des séances A, B, C (dans l'ordre).
    private static func allExercises() -> [Exercise] {
        var list: [Exercise] = []

        // ─── Séance A — Push ───────────────────────────
        list.append(Exercise(name: "Chest press machine",                  repsMin: 8,  repsMax: 10, restSec: 90, setsTarget: 4, workoutType: .a, order: 1))
        list.append(Exercise(name: "Développé incliné haltères (30°)",     repsMin: 8,  repsMax: 10, restSec: 90, setsTarget: 3, workoutType: .a, order: 2))
        list.append(Exercise(name: "Pec deck",                             repsMin: 10, repsMax: 12, restSec: 60, setsTarget: 3, workoutType: .a, order: 3))
        list.append(Exercise(name: "Développé épaules machine",            repsMin: 8,  repsMax: 10, restSec: 90, setsTarget: 3, workoutType: .a, order: 4))
        list.append(Exercise(name: "Élévations latérales haltères",        repsMin: 12, repsMax: 15, restSec: 60, setsTarget: 3, workoutType: .a, order: 5))
        list.append(Exercise(name: "Extensions triceps poulie (corde)",    repsMin: 10, repsMax: 12, restSec: 60, setsTarget: 3, workoutType: .a, order: 6))
        list.append(Exercise(name: "Triceps kickback haltère",             repsMin: 12, repsMax: 12, restSec: 45, setsTarget: 2, workoutType: .a, order: 7, isOptional: true))

        // ─── Séance B — Pull ───────────────────────────
        list.append(Exercise(name: "Tirage vertical poulie prise large",   repsMin: 8,  repsMax: 10, restSec: 90, setsTarget: 4, workoutType: .b, order: 1))
        list.append(Exercise(name: "Tirage horizontal machine/poulie",     repsMin: 8,  repsMax: 10, restSec: 90, setsTarget: 3, workoutType: .b, order: 2))
        list.append(Exercise(name: "Tirage poitrine prise neutre machine", repsMin: 10, repsMax: 12, restSec: 60, setsTarget: 3, workoutType: .b, order: 3))
        list.append(Exercise(name: "Pull-over haltère sur banc",           repsMin: 12, repsMax: 12, restSec: 60, setsTarget: 3, workoutType: .b, order: 4))
        list.append(Exercise(name: "Curl haltères assis",                  repsMin: 10, repsMax: 12, restSec: 60, setsTarget: 3, workoutType: .b, order: 5))
        list.append(Exercise(name: "Curl marteau debout",                  repsMin: 10, repsMax: 12, restSec: 60, setsTarget: 3, workoutType: .b, order: 6))
        list.append(Exercise(name: "Crunch machine abdos",                 repsMin: 12, repsMax: 15, restSec: 45, setsTarget: 3, workoutType: .b, order: 7, isOptional: true))

        // ─── Séance C — Pecs + Bras + Épaules + Jambes machines ─
        list.append(Exercise(name: "Développé couché haltères à plat",     repsMin: 8,  repsMax: 10, restSec: 90, setsTarget: 4, workoutType: .c, order: 1))
        list.append(Exercise(name: "Pec deck",                             repsMin: 10, repsMax: 12, restSec: 60, setsTarget: 3, workoutType: .c, order: 2))
        list.append(Exercise(name: "Curl barre EZ ou haltères",            repsMin: 8,  repsMax: 10, restSec: 75, setsTarget: 3, workoutType: .c, order: 3))
        list.append(Exercise(name: "Extension triceps verticale haltère",  repsMin: 10, repsMax: 12, restSec: 60, setsTarget: 3, workoutType: .c, order: 4))
        list.append(Exercise(name: "Élévations latérales",                 repsMin: 12, repsMax: 15, restSec: 60, setsTarget: 3, workoutType: .c, order: 5))
        list.append(Exercise(name: "Presse à cuisses pieds hauts",         repsMin: 10, repsMax: 12, restSec: 90, setsTarget: 3, workoutType: .c, order: 6))
        list.append(Exercise(name: "Leg extension",                        repsMin: 12, repsMax: 12, restSec: 60, setsTarget: 2, workoutType: .c, order: 7))
        list.append(Exercise(name: "Leg curl",                             repsMin: 12, repsMax: 12, restSec: 60, setsTarget: 2, workoutType: .c, order: 8))

        return list
    }
}

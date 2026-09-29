import SwiftUI
import SwiftData

@main
struct MuscuAppApp: App {

    /// Conteneur SwiftData : déclare tous les @Model utilisés par l'app.
    /// SwiftData persiste automatiquement dans Application Support/default.store.
    let container: ModelContainer = {
        do {
            let schema = Schema([
                Exercise.self,
                WorkoutSession.self,
                ExerciseSet.self,
                BodyWeightEntry.self,
                ShakerLog.self,
                SupplementLog.self
            ])
            let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            return try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("ModelContainer init failed: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .preferredColorScheme(.dark)   // mode sombre par défaut
                .onAppear {
                    // Seed du catalogue d'exercices au 1er lancement
                    SeedData.seedIfNeeded(container.mainContext)
                }
        }
        .modelContainer(container)
    }
}

import SwiftUI

/// Navigation principale par TabBar.
/// 5 onglets : Aujourd'hui · Historique · Poids · Shakers · Courses.
struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                TodayView()
            }
            .tabItem {
                Label("Aujourd'hui", systemImage: "sun.max.fill")
            }

            NavigationStack {
                HistoryView()
            }
            .tabItem {
                Label("Historique", systemImage: "list.bullet.rectangle.portrait")
            }

            NavigationStack {
                BodyWeightView()
            }
            .tabItem {
                Label("Poids", systemImage: "scalemass.fill")
            }

            NavigationStack {
                ShakersView()
            }
            .tabItem {
                Label("Shakers", systemImage: "cup.and.saucer.fill")
            }

            NavigationStack {
                ShoppingListView()
            }
            .tabItem {
                Label("Courses", systemImage: "cart.fill")
            }
        }
        .tint(Theme.Colors.accent)
    }
}

#Preview {
    MainTabView()
        .modelContainer(for: [
            Exercise.self,
            WorkoutSession.self,
            ExerciseSet.self,
            BodyWeightEntry.self,
            ShakerLog.self,
            SupplementLog.self
        ], inMemory: true)
}

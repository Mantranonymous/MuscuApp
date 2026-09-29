# MuscuApp

Application iOS native pour suivre un programme de musculation 3 séances/sem (Push / Pull / Pecs+Bras+Jambes machines) et la nutrition associée.

## Stack
- iOS 17+ · Swift 5.9+ · SwiftUI · SwiftData
- Architecture : MVVM léger
- Zéro dépendance externe

## Mise en route

1. Créer un projet Xcode `MuscuApp` (iOS App, SwiftUI, SwiftData) à l'emplacement `/Users/simonyeche/Desktop/perso/`.
2. Supprimer les fichiers générés `MuscuAppApp.swift` et `Item.swift`.
3. Faire glisser le dossier `MuscuApp/` (le sous-dossier de ce dépôt) dans le navigateur Xcode → "Create groups".
4. ⌘B pour builder, ⌘R pour lancer en simulateur.

## Sideload iPhone (sans compte Apple Dev payant)
- Xcode → Settings → Accounts → ajouter Apple ID gratuit
- Cible projet → Signing & Capabilities → Personal Team
- Brancher iPhone, le sélectionner comme device, ⌘R
- iPhone → Réglages → Général → VPN et gestion → faire confiance au certif
- ⚠️ Les apps installées via Apple ID gratuit expirent au bout de 7 jours

## Roadmap MVP

- [x] Sprint 1 — Today + navigation + seed data
- [ ] Sprint 2 — Mode séance avec timer
- [ ] Sprint 3 — Historique + suivi poids + courses

## Architecture

Voir `MuscuApp/` :
- `App/` — entry point + navigation
- `Models/` — entités SwiftData
- `Services/` — logique métier pure
- `Features/<Écran>/` — Vue + ViewModel
- `Shared/` — composants UI réutilisables, thème

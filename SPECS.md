# Scrabble Trainer App - Technical Specs

## Architecture
**Pattern:** Riverpod + Clean Architecture (Feature-first).
**Navigation:** GoRouter.

## Stack
- **SDK:** Flutter (Stable).
- **State Management:** Flutter Riverpod.
- **Database:** Drift (SQLite).
  - **Tables:**
    - `Dictionary`: mot (PK), definition, genre, pluriel, etc.
    - `Progress`: mot (FK), next_review (DateTime), interval (int), ease_factor (double).
  - **Strategy Update:** Le dictionnaire est chargé/mis à jour indépendamment. La progression est liée à la chaîne de caractères du mot (Clé stable).
- **UI:** Material 3 with `dynamic_color` (Material You).

## Features Update
1. **Settings:**
   - ThemeMode (System/Light/Dark).
   - Default Tab.
   - Dictionary Selection (ODS9 / English / ODS10 later).
2. **Train:** Spaced Repetition (Anki-like).
3. **Score:** Simple point counter.

## Roadmap (2 weeks)
1. **Setup:** Init project, linting, CI structures.
2. **Database:** Drift schema, Asset population (ODS9).
3. **Features:** Search, Train (Logic SRS), Score.
4. **Polish:** Material You, Icons, Splash.
5. **Release:** Signing, Play Console assets.

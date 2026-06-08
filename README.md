# Articulately

**Articulate with Confidence**

Articulately is a speech articulation practice app built with Flutter. It helps users improve their verbal clarity, pronunciation, and speaking confidence through flashcard-based exercises organized by difficulty and category.

---

## What Is Articulately?

Articulately provides structured practice sessions where users read through speech exercises presented as flashcards. The app uses a swipe-based interaction model — swipe right if you nailed the articulation, swipe left if you need more practice. Cards you struggle with are automatically replayed in a retry round until you master them.

The app tracks session time and awards performance badges (Bronze, Silver, Gold) based on your average speed per card, encouraging consistent improvement.

---

## Who Is Articulately For?

- **Speech therapy patients** — practicing articulation exercises assigned by their therapist
- **Public speakers & presenters** — warming up before talks or rehearsing difficult phrases
- **Language learners** — drilling pronunciation of challenging words and sentences
- **Voice actors & performers** — building articulation speed and clarity
- **Anyone** who wants to speak more clearly and confidently in daily life

---

## Current Features

### Difficulty Levels
Three levels of practice content — Easy, Medium, and Hard — plus a Random mode that picks a level for you. Content scales from simple phrases to complex tongue-twisters and multi-syllable sequences.

### Category-Based Organization
Flashcards are grouped into themed categories (e.g. "Daily Warm-ups", "Tongue Twisters", "Professional Phrases"). Users pick a category after selecting their difficulty.

### Swipe-Based Practice
Cards are presented full-screen with swipe gestures:
- **Swipe right** → "Got it!" — you articulated it well
- **Swipe left** → "Not yet" — needs more practice

Visual overlays and tilt animations provide real-time feedback during the swipe.

### Retry Round
Cards marked as "Not yet" are automatically collected and replayed after you finish the main deck. The retry loop continues until all cards are mastered or you exit.

### Practice Timer
A live timer tracks how long each session takes, displayed in the app bar during practice.

### Achievement Badges
After completing a session, you earn a badge based on your average time per card:
- **Gold** — ≤ 5 seconds/card
- **Silver** — ≤ 10 seconds/card
- **Bronze** — > 10 seconds/card

### Session Summary
A post-session screen shows your time, card count, difficulty level, and earned badge. From here you can try the next difficulty, retry the same set, or return home.

### Offline-Ready Architecture
The app is designed with a repository pattern that supports both remote (Supabase) and local bundled content, ensuring it works even without network connectivity.

### Admin Panel
An admin login and management screen for content administration.

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter (Web, iOS, Android) |
| State Management | Riverpod |
| Routing | go_router |
| Database | Supabase (PostgreSQL) |
| Typography | Google Fonts |
| Language | Dart 3.11+ |

---

## Project Structure

```
lib/
├── main.dart                 # App entry point, Supabase init
├── app.dart                  # Root widget with ProviderScope
├── router.dart               # go_router route definitions
├── theme.dart                # Design tokens, colours, typography
├── data/
│   ├── content_repository.dart         # Repository pattern (remote + fallback)
│   └── supabase_content_data_source.dart  # Supabase queries
├── models/
│   ├── category.dart         # Category data model
│   ├── flashcard.dart        # Flashcard data model
│   ├── flashcard_set.dart    # Grouped flashcard collection
│   ├── difficulty.dart       # Difficulty enum + helpers
│   ├── session_state.dart    # Practice session state
│   └── achievement_badge.dart # Badge tier logic
├── providers/
│   ├── content_provider.dart  # ContentRepository provider
│   ├── session_provider.dart  # Session state notifier
│   └── timer_provider.dart    # Practice timer
├── screens/
│   ├── home_screen.dart              # Difficulty selection
│   ├── category_list_screen.dart     # Category picker
│   ├── flashcard_screen.dart         # Swipe-based practice
│   ├── session_complete_screen.dart  # Completion celebration
│   ├── practice_summary_screen.dart  # Stats & badge
│   ├── admin_login_screen.dart       # Admin auth
│   └── admin_screen.dart             # Content management
└── widgets/
    ├── app_logo.dart              # Brand mark
    ├── flashcard_card.dart        # Card display widget
    ├── category_tile.dart         # Category list item
    ├── difficulty_button.dart     # Difficulty selector
    ├── nav_arrow_button.dart      # Navigation arrows
    ├── progress_indicator.dart    # Session progress bar
    ├── practice_timer_display.dart # Timer display
    ├── achievement_badge.dart     # Badge widget
    └── pressable.dart             # Tap animation wrapper
```

---

## Getting Started

### Prerequisites
- Flutter SDK 3.11+
- Dart 3.11+
- A Supabase project (or use bundled local content for offline dev)

### Run the app
```bash
flutter pub get
flutter run
```

### Run tests
```bash
flutter test
```

---

## What's Next

Things that actually need doing, in rough priority order:

1. **User accounts** — Supabase Auth so progress persists across devices. Without this, everything resets on reinstall.
2. **Session history** — Store completed sessions in Supabase. Show a simple history screen with date, category, time, and badge earned.
3. **Spaced repetition** — Cards you get wrong should show up more often in future sessions. Doesn't need to be fancy — even a basic "last failed" weight is better than pure random.
4. **More content** — The app is only as good as its flashcard library. Add more categories and difficulty tiers. Consider a simple CSV import flow for bulk content.
5. **Polish the UI** — The current design works but it's generic. Custom branding, better animations on the card swipe, and a proper empty state when categories have no cards.
6. **Audio playback** — Optional pronunciation audio per card. Useful for language learners and therapy patients who need a reference.
7. **Tests** — The test suite is thin. Widget tests for each screen and integration tests for the core flows (select → practice → complete) would prevent regressions.
8. **CI/CD** — GitHub Actions running `flutter test` and `flutter analyze` on PRs. Deploy web builds to Firebase Hosting or Vercel on merge to main.

---

## License

This project is private and not published to pub.dev.

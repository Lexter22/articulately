# Project Structure

## Top-Level Layout

```
articulately/
├── lib/                # Application source code
├── test/               # Unit and widget tests
├── supabase/           # Supabase migrations and seed data
├── assets/images/      # Static image assets
├── android/            # Android platform shell
├── ios/                # iOS platform shell
├── web/                # Web platform shell
├── macos/              # macOS platform shell
├── linux/              # Linux platform shell
├── windows/            # Windows platform shell
├── .agents/            # AI agent skills (Genkit, Firebase, etc.)
├── .kiro/              # Kiro specs and steering files
├── pubspec.yaml        # Dart/Flutter dependencies
└── analysis_options.yaml
```

## `lib/` Organisation

The source follows a layered architecture:

```
lib/
├── main.dart           # Entry point — Supabase init, runs ProviderScope(child: App())
├── app.dart            # Root MaterialApp widget
├── router.dart         # go_router route definitions + auth redirect guard
├── theme.dart          # AppTheme class — colours, spacing constants, ThemeData
├── data/               # Data layer (repositories + data sources)
│   ├── content_repository.dart           # Abstracts data access
│   └── supabase_content_data_source.dart # Supabase queries
├── models/             # Plain Dart data classes and enums
│   ├── category.dart
│   ├── flashcard.dart
│   ├── flashcard_set.dart
│   ├── difficulty.dart
│   ├── session_state.dart
│   ├── achievement_badge.dart
│   └── preset_option.dart
├── providers/          # Riverpod providers (state management)
│   ├── content_provider.dart   # ContentRepository provider
│   ├── session_provider.dart   # Session state notifier
│   └── timer_provider.dart     # Practice timer
├── screens/            # Full-page route widgets
│   ├── home_screen.dart
│   ├── category_list_screen.dart
│   ├── card_count_selector_screen.dart
│   ├── flashcard_screen.dart
│   ├── session_complete_screen.dart
│   ├── practice_summary_screen.dart
│   ├── admin_login_screen.dart
│   └── admin_screen.dart
├── widgets/            # Reusable UI components
│   ├── flashcard_card.dart
│   ├── difficulty_button.dart
│   ├── category_tile.dart
│   ├── achievement_badge.dart
│   ├── app_logo.dart
│   ├── nav_arrow_button.dart
│   ├── practice_timer_display.dart
│   ├── progress_indicator.dart
│   └── pressable.dart
└── utils/              # Pure helper functions
    └── deck_preparation.dart
```

## Architecture Conventions

- **Repository pattern**: `ContentRepository` wraps `SupabaseContentDataSource`. All database access goes through the repository.
- **Riverpod providers**: Each concern (content, session, timer) has its own provider file. Screens consume providers via `ConsumerWidget` or `ref.watch`.
- **Screens vs Widgets**: `screens/` contains full-page route targets. `widgets/` contains composable, reusable pieces.
- **Theme constants**: All colours and spacing values are static constants on `AppTheme`. Use `AppTheme.colorXxx` and `AppTheme.spacingXx` rather than inline literals.
- **Routing**: All routes are defined in `router.dart` using `GoRoute`. Auth guards redirect unauthenticated users away from `/admin`.
- **Models are plain Dart**: No code generation (freezed, json_serializable). Models are simple classes with named constructors and `fromJson` factory methods where needed.
- **StatelessWidget by default**: Use `StatelessWidget` (or `ConsumerWidget`) unless local mutable state is required.
- **Relative imports within lib/**: Use relative paths (`'../models/difficulty.dart'`) not package imports for intra-project references.

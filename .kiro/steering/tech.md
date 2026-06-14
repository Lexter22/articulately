# Tech Stack & Build System

## Core Stack

| Layer              | Technology                          |
|--------------------|-------------------------------------|
| Framework          | Flutter (Web, iOS, Android, macOS, Windows, Linux) |
| Language           | Dart 3.11+                          |
| State Management   | Riverpod (flutter_riverpod ^2.6.1)  |
| Routing            | go_router ^14.8.1                   |
| Database / Backend | Supabase (PostgreSQL) via supabase_flutter ^2.9.1 |
| Typography         | Google Fonts (Nunito)               |
| Linting            | flutter_lints ^6.0.0                |
| Testing            | flutter_test + glados ^1.1.7 (property-based testing) |

## Environment Variables

Supabase credentials are injected via `--dart-define`:
- `SUPABASE_URL`
- `SUPABASE_ANON_KEY`

An `.env.json` file exists at the project root for local development.

## Common Commands

```bash
# Install dependencies
flutter pub get

# Run the app (web, with Supabase env vars)
flutter run -d chrome --dart-define-from-file=.env.json

# Run the app (mobile/desktop)
flutter run --dart-define-from-file=.env.json

# Run all tests
flutter test

# Run static analysis
flutter analyze

# Format code
dart format .

# Supabase local dev
supabase start
supabase db reset   # applies migrations + seed.sql
```

## Supabase

- Migrations live in `supabase/migrations/`
- Seed data in `supabase/seed.sql`
- Use Supabase CLI for local development and migration management

## Linting

Uses `package:flutter_lints/flutter.yaml` as the base rule set (defined in `analysis_options.yaml`). No custom overrides currently active.

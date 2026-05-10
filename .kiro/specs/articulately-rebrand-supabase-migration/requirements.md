# Requirements Document

## Introduction

Articulately is a Flutter-based speech articulation practice app. This spec covers two major changes:

1. **Rebranding** — Remove the current Duolingo-inspired visual identity (Nunito font, green `#58CC02` primary, chunky bottom-border buttons, yellow/coral accent palette) and replace it with a clean, minimal, original brand identity unique to Articulately.

2. **Database Migration** — Replace Firebase (Firestore + Analytics) with Supabase as the backend database, and introduce an ORM layer (Drizzle ORM or Prisma) for schema management and type-safe queries where applicable.

The app is a Flutter project targeting web, iOS, and Android. The data layer currently has both a `FirestoreContentDataSource` (live) and a `LocalDataSource` (bundled content). The migration must preserve all existing content and functionality.

---

## Glossary

- **App**: The Articulately Flutter application.
- **Theme**: The `AppTheme` class in `lib/theme.dart` that defines all colours, typography, spacing, and component styles.
- **AppLogo**: The custom-painted widget in `lib/widgets/app_logo.dart` representing the Articulately brand mark.
- **DataSource**: An abstraction that provides categories and flashcards to the `ContentRepository`.
- **FirestoreDataSource**: The existing `FirestoreContentDataSource` class that reads from Cloud Firestore.
- **SupabaseDataSource**: The new data source class that reads from Supabase using the `supabase_flutter` package.
- **ContentRepository**: The `ContentRepository` class in `lib/data/content_repository.dart` that mediates between providers and the data source.
- **LocalDataSource**: The existing `LocalDataSource` class that serves bundled content from `content_data.dart`.
- **ORM**: Object-Relational Mapper — a tool that provides type-safe, schema-driven database access. Candidates: Drizzle ORM (JS/TS, used via a Supabase Edge Function or separate backend) or Prisma (JS/TS, same approach).
- **Supabase**: An open-source Firebase alternative providing a PostgreSQL database, REST/realtime API, and auth.
- **Category**: A grouping of flashcards (e.g. "Daily Warm-ups") with an `id`, `name`, and `subtitle`.
- **Flashcard**: A single practice card with `id`, `text`, `categoryId`, and `difficulty`.
- **Difficulty**: An enum with values `easy`, `medium`, `hard`.

---

## Requirements

### Requirement 1: Remove Duolingo-Inspired Visual Identity

**User Story:** As a product owner, I want all Duolingo-inspired design elements removed from the app, so that Articulately has a fully original visual identity.

#### Acceptance Criteria

1. THE Theme SHALL NOT use the colour `#58CC02` (Duolingo green) or any colour derived from it as the primary brand colour.
2. THE Theme SHALL NOT use Nunito as the primary typeface.
3. THE Theme SHALL NOT use the chunky bottom-border button style (4 dp bottom `BorderSide` with a matching shadow offset) as the default button decoration.
4. THE Theme SHALL NOT reference "Duolingo" in any code comment, variable name, or string literal.

---

### Requirement 2: Establish Original Articulately Brand Identity

**User Story:** As a product owner, I want a clean, minimal, and original brand identity applied consistently across the app, so that Articulately feels distinct and professional.

#### Acceptance Criteria

1. THE Theme SHALL define a new primary colour palette that is distinct from Duolingo's palette and appropriate for a speech/communication app.
2. THE Theme SHALL specify a single primary typeface sourced from Google Fonts that is different from Nunito and suits a clean, minimal aesthetic.
3. THE Theme SHALL define consistent spacing, border-radius, and elevation tokens that are applied uniformly across all screens and widgets.
4. THE AppLogo SHALL be updated to reflect the new brand identity while retaining its speech-bubble-with-sound-wave concept or replacing it with an equally meaningful mark.
5. WHEN the app is rendered on any supported platform (web, iOS, Android), THE App SHALL display only the new brand colours, typeface, and component styles with no remnants of the previous Duolingo-inspired palette.
6. THE Theme SHALL include a named colour for each semantic role: primary, secondary, background, surface, error, text-primary, text-secondary, text-on-colour, and border.

---

### Requirement 3: Replace Firebase Dependencies with Supabase

**User Story:** As a developer, I want Firebase removed and Supabase installed as the database backend, so that the app uses a PostgreSQL-based, open-source infrastructure.

#### Acceptance Criteria

1. THE App SHALL NOT import or initialise `firebase_core`, `firebase_analytics`, or `cloud_firestore` after the migration is complete.
2. THE App SHALL initialise the Supabase client at startup using `supabase_flutter` before the widget tree is rendered.
3. THE SupabaseDataSource SHALL implement the same interface as `FirestoreContentDataSource` — providing `getCategories()` and `getFlashcards({categoryId, difficulty})` — so that `ContentRepository` requires no logic changes.
4. WHEN `getCategories()` is called, THE SupabaseDataSource SHALL query the `categories` table in Supabase and return a `List<Category>` ordered by `name`.
5. WHEN `getFlashcards` is called with a `categoryId` and `difficulty`, THE SupabaseDataSource SHALL query the `flashcards` table filtered by `category_id` and `difficulty` and return a `List<Flashcard>`.
6. IF the Supabase client returns an error response, THEN THE SupabaseDataSource SHALL throw a typed exception that the `ContentRepository` can catch and surface to the UI.
7. THE `pubspec.yaml` SHALL list `supabase_flutter` as a dependency and SHALL NOT list `firebase_core`, `firebase_analytics`, or `cloud_firestore`.

---

### Requirement 4: Define Supabase Database Schema

**User Story:** As a developer, I want a well-defined PostgreSQL schema for Supabase, so that the database structure is explicit, version-controlled, and matches the app's data model.

#### Acceptance Criteria

1. THE Schema SHALL define a `categories` table with columns: `id` (text, primary key), `name` (text, not null), `subtitle` (text, not null).
2. THE Schema SHALL define a `flashcards` table with columns: `id` (text, primary key), `text` (text, not null), `category_id` (text, not null, foreign key → `categories.id`), `difficulty` (text, not null, constrained to `'easy'`, `'medium'`, `'hard'`).
3. THE Schema SHALL include a seed migration that inserts all existing content from `content_data.dart` (5 categories, 75+ flashcards) into the Supabase tables.
4. THE Schema files SHALL be stored under `supabase/migrations/` so they are compatible with the Supabase CLI migration workflow.

---

### Requirement 5: ORM Integration Assessment and Setup

**User Story:** As a developer, I want to know whether an ORM (Drizzle or Prisma) can be used with Supabase in a Flutter project, and if so, have it set up, so that schema management and type-safe queries are easier to maintain.

#### Acceptance Criteria

1. THE Spec SHALL document the ORM compatibility assessment: Drizzle ORM and Prisma are JavaScript/TypeScript ORMs and cannot run inside a Flutter/Dart client directly; they CAN be used in a companion Node.js backend, Supabase Edge Functions, or a separate migration/seeding script.
2. WHERE a companion Node.js tooling layer is desired, THE Project SHALL include a `supabase/functions/` directory or a `scripts/` directory containing an ORM schema file (Drizzle `schema.ts` or Prisma `schema.prisma`) that mirrors the PostgreSQL schema.
3. THE ORM schema file SHALL define the same tables and constraints as the SQL migration files in Requirement 4, ensuring the two sources of truth remain in sync.
4. THE Flutter client SHALL use `supabase_flutter` directly (not an ORM) for all runtime database queries, as no Dart ORM with Supabase support is currently production-ready.
5. WHERE Drizzle ORM is chosen, THE `scripts/` directory SHALL include a `drizzle.config.ts` and a `package.json` with `drizzle-kit` as a dev dependency for running migrations and generating types.

---

### Requirement 6: Graceful Fallback to Local Data Source

**User Story:** As a developer, I want the app to fall back to the bundled `LocalDataSource` when Supabase is unreachable, so that the app remains functional offline or during backend outages.

#### Acceptance Criteria

1. THE ContentRepository SHALL accept both a `SupabaseDataSource` and a `LocalDataSource` and attempt the remote source first.
2. IF the `SupabaseDataSource` throws an exception, THEN THE ContentRepository SHALL transparently retry using the `LocalDataSource` and return its result.
3. THE App SHALL not display an error screen when the fallback to `LocalDataSource` is triggered; it SHALL continue to function normally with bundled content.
4. WHILE the `SupabaseDataSource` is unavailable, THE App SHALL display a non-blocking indicator (e.g. a subtle banner or icon) informing the user that offline content is being used.

---

### Requirement 7: Remove Firebase Configuration Artefacts

**User Story:** As a developer, I want all Firebase configuration files and references cleaned up, so that the project has no residual Firebase footprint.

#### Acceptance Criteria

1. THE Project SHALL NOT contain `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) after the migration.
2. THE `firebase.json` and `.firebaserc` files SHALL be removed or emptied of app-specific configuration.
3. THE `main.dart` SHALL NOT contain `FirebaseOptions`, `Firebase.initializeApp`, or `FirebaseAnalytics` references after the migration.
4. THE `lib/data/firestore_content_data_source.dart` file SHALL be deleted or replaced by `lib/data/supabase_content_data_source.dart`.
5. THE Android `build.gradle` and iOS `Podfile` SHALL NOT reference any Firebase or Google Services plugins after the migration.

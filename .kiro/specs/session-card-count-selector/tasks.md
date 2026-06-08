# Implementation Plan: Session Card Count Selector

## Overview

This plan implements an intermediate card count selection screen between category selection and flashcard practice. The implementation proceeds bottom-up: pure utility functions first, then model/state changes, then the UI screen, and finally wiring into existing navigation.

## Tasks

- [x] 1. Create utility functions and data model
  - [x] 1.1 Create `lib/utils/deck_preparation.dart` with `prepareDeck` and `isPresetEnabled` pure functions
    - Implement `prepareDeck(List<Flashcard> cards, int count, {Random? random})` that shuffles cards and returns the first `count` items
    - If `count >= cards.length`, return all cards shuffled
    - Implement `isPresetEnabled(int availableCount, int? presetCount)` returning `true` when `availableCount >= presetCount` (or `availableCount > 0` for null/All)
    - _Requirements: 3.1, 3.2, 3.3, 4.1, 4.2, 4.4_

  - [x] 1.2 Create `lib/models/preset_option.dart` with `PresetOption` data class and `defaultPresets` constant
    - Define `PresetOption` with `label`, `subtitle`, and `cardCount` (nullable int where null means all)
    - Define `defaultPresets` list with Quick (5), Standard (10), and All (null)
    - _Requirements: 1.4_

  - [x]* 1.3 Write property tests for `prepareDeck` shuffle preservation (Property 1)
    - **Property 1: Shuffle preserves deck membership**
    - **Validates: Requirements 3.1**
    - Use `glados` to generate random flashcard lists (1–100 items)
    - Assert output contains exactly the same card IDs as input

  - [x]* 1.4 Write property tests for `prepareDeck` trim correctness (Property 2)
    - **Property 2: Trim produces correct subset**
    - **Validates: Requirements 3.2, 3.3**
    - Use `glados` to generate random lists + random count (0–200)
    - Assert output length equals `min(count, cards.length)` and all output cards exist in input

  - [x]* 1.5 Write property tests for `isPresetEnabled` threshold logic (Property 3)
    - **Property 3: Preset enablement follows threshold rules**
    - **Validates: Requirements 4.1, 4.2, 4.4**
    - Use `glados` to generate random counts (0–1000) × thresholds {1, 5, 10}
    - Assert enabled iff `availableCount >= threshold`

- [x] 2. Extend SessionNotifier with `startSessionWithDeck` method
  - [x] 2.1 Add `startSessionWithDeck(Difficulty difficulty, String categoryId, List<Flashcard> cards)` to `SessionNotifier`
    - Set `_originalCards` and `_activeDeck` from the provided cards list
    - Initialize a fresh `SessionState` with the given difficulty and categoryId
    - Keep existing `startSession` method intact for backward compatibility
    - _Requirements: 3.4, 2.1, 2.2, 2.3_

  - [x]* 2.2 Write unit tests for `startSessionWithDeck`
    - Verify session state is initialized correctly with provided deck
    - Verify `activeDeck` matches the provided cards list
    - Verify existing `startSession` method still works unchanged
    - _Requirements: 3.4_

- [x] 3. Checkpoint - Ensure all tests pass
  - Ensure all tests pass, ask the user if questions arise.

- [x] 4. Create CardCountSelectorScreen widget
  - [x] 4.1 Create `lib/screens/card_count_selector_screen.dart` as a `ConsumerStatefulWidget`
    - Accept `categoryId` and `difficulty` as constructor parameters (from route query params)
    - On `initState`, fetch available cards from `ContentRepository` using `getFlashcardSet`
    - Display loading indicator while fetching; disable all preset buttons during load
    - On success, display category name, difficulty, total card count ("{count} cards available"), and three preset buttons
    - On error, display error message with retry button
    - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7_

  - [x] 4.2 Implement preset selection and session start logic in `CardCountSelectorScreen`
    - On preset tap: call `prepareDeck` with the available cards and selected count
    - Call `sessionNotifier.startSessionWithDeck` with difficulty, categoryId, and trimmed deck
    - Navigate to `/flashcard?categoryId=...&difficulty=...` on success
    - Show snackbar error and stay on screen if session initiation fails
    - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.5, 3.1, 3.2, 3.3_

  - [x] 4.3 Implement preset enablement and insufficient-cards handling in `CardCountSelectorScreen`
    - Use `isPresetEnabled` to determine which presets are enabled based on available card count
    - Disable "Quick" when fewer than 5 cards available
    - Disable "Standard" when fewer than 10 cards available
    - Disable all presets and show "No cards available for this combination" when count is zero
    - Show available count on disabled preset buttons
    - _Requirements: 4.1, 4.2, 4.3, 4.4, 4.5_

  - [x] 4.4 Implement back navigation from `CardCountSelectorScreen`
    - Add back button as leading widget in app bar
    - Back button and system back gesture navigate to CategoryListScreen preserving difficulty
    - _Requirements: 5.1, 5.2, 5.3_

  - [x]* 4.5 Write widget tests for `CardCountSelectorScreen`
    - Test loading state shows progress indicator and disabled buttons
    - Test successful load shows card count and enabled/disabled presets
    - Test error state shows error message and retry button
    - Test tapping enabled preset navigates to flashcard screen
    - Test tapping disabled preset does nothing
    - Test zero cards shows "No cards available" message
    - Test back button navigates to categories with correct difficulty
    - _Requirements: 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 4.3, 5.1_

- [x] 5. Wire navigation flow
  - [x] 5.1 Add `/card-count-selector` route to `lib/router.dart`
    - Register new `GoRoute` with path `/card-count-selector`
    - Extract `categoryId` and `difficulty` from query parameters
    - Pass them to `CardCountSelectorScreen` constructor
    - Add import for `card_count_selector_screen.dart`
    - _Requirements: 1.1_

  - [x] 5.2 Update `CategoryListScreen._onCategoryTapped` to navigate to card count selector
    - Replace direct flashcard navigation with `context.push('/card-count-selector?categoryId=$categoryId&difficulty=$difficulty')`
    - Remove the card-fetching logic from `_onCategoryTapped` (it moves to CardCountSelectorScreen)
    - _Requirements: 1.1_

  - [x]* 5.3 Write integration tests for the full navigation flow
    - Test Category → Selector → Flashcard navigation
    - Verify session starts with correct trimmed deck size
    - Verify back navigation preserves difficulty parameter
    - _Requirements: 1.1, 2.4, 5.2, 5.3_

- [x] 6. Final checkpoint - Ensure all tests pass
  - Ensure all tests pass, ask the user if questions arise.

## Notes

- Tasks marked with `*` are optional and can be skipped for faster MVP
- Each task references specific requirements for traceability
- Checkpoints ensure incremental validation
- Property tests validate universal correctness properties from the design document
- Unit and widget tests validate specific examples and edge cases
- The `glados` package is already available in dev_dependencies for property-based testing

## Task Dependency Graph

```json
{
  "waves": [
    { "id": 0, "tasks": ["1.1", "1.2"] },
    { "id": 1, "tasks": ["1.3", "1.4", "1.5", "2.1"] },
    { "id": 2, "tasks": ["2.2"] },
    { "id": 3, "tasks": ["4.1"] },
    { "id": 4, "tasks": ["4.2", "4.3", "4.4"] },
    { "id": 5, "tasks": ["4.5", "5.1"] },
    { "id": 6, "tasks": ["5.2"] },
    { "id": 7, "tasks": ["5.3"] }
  ]
}
```

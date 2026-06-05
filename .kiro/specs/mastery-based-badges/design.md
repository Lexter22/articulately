# Implementation Plan

## Overview

Replace the speed-based badge tier calculation with a mastery-based approach using retry count. The timer remains visible but is decoupled from badge logic. The `AchievementBadge.tierFor` method signature changes from `(int cardCount, Duration elapsed)` to `(int retryCount)`.

## Architecture

### Modified Files

1. **`lib/models/achievement_badge.dart`** — Change `tierFor` to accept `retryCount` only
2. **`lib/models/session_state.dart`** — Add `retryCardCount` field
3. **`lib/providers/session_provider.dart`** — Increment `retryCardCount` when a card first enters retry
4. **`lib/screens/practice_summary_screen.dart`** — Pass retry count to badge calculation; add retry count stat
5. **`lib/widgets/achievement_badge.dart`** — Remove unused `sessionTime` parameter

### No New Dependencies

The retry count is already conceptually tracked via `badCardIds` in `SessionState`. We add a simple integer counter to persist the count across retry rounds (since `badCardIds` empties on completion).

## Components and Interfaces

### AchievementBadge (Model)

```dart
static AchievementBadge tierFor(int retryCount) {
  if (retryCount <= 0) {
    return const AchievementBadge(tier: BadgeTier.gold, label: 'Gold');
  } else if (retryCount <= 2) {
    return const AchievementBadge(tier: BadgeTier.silver, label: 'Silver');
  } else {
    return const AchievementBadge(tier: BadgeTier.bronze, label: 'Bronze');
  }
}
```

**Tier thresholds:**
| Retry Count | Tier |
|---|---|
| 0 | Gold |
| 1–2 | Silver |
| 3+ | Bronze |

### SessionState (Model)

Add a new field:
```dart
/// Number of unique cards that entered a retry round (never decremented).
final int retryCardCount;
```

### SessionNotifier (Provider)

In `markBad()`, increment `retryCardCount` when a card ID is added to `badCardIds` for the first time:
```dart
void markBad() {
  final idx = state.currentIndex;
  final cardId = _activeDeck[idx].id;
  final newBadIds = Set<String>.from(state.badCardIds)..add(cardId);
  final newRetryCount = newBadIds.length > state.badCardIds.length
      ? state.retryCardCount + 1
      : state.retryCardCount;
  _advance(newBadIds, newRetryCount);
}
```

### AchievementBadgeWidget (Widget)

Remove `sessionTime` parameter since time is no longer relevant to badge display.

### PracticeSummaryScreen

- Read `session.retryCardCount` as the retry count
- Call `AchievementBadge.tierFor(session.retryCardCount)`
- Add a fourth stat column showing retry count with `Icons.refresh_rounded`

## Data Models

### SessionState Changes

```dart
class SessionState {
  final Difficulty? difficulty;
  final String? categoryId;
  final int currentIndex;
  final Duration elapsed;
  final bool isComplete;
  final Set<String> badCardIds;
  final bool isRetryRound;
  final int retryCardCount; // NEW: counts unique cards that entered retry
  // ...
}
```

Default value: `0`. Reset to `0` in `resetSession()` and `exitSession()`.

## Error Handling

- If `retryCount` is negative (should not happen), treat as 0 (Gold). The `<= 0` check handles this defensively.
- If session completes without proper state (null difficulty, empty categoryId), the badge calculation still works since it depends only on `retryCardCount`.

## Correctness Properties

### Property 1: Tier boundaries are exhaustive and mutually exclusive

**Validates: Requirements 1.1, 1.2, 1.3**

For all non-negative integers `retryCount`, exactly one of Gold, Silver, or Bronze is returned. No gaps, no overlaps.

- `retryCount == 0` → Gold
- `retryCount ∈ {1, 2}` → Silver
- `retryCount >= 3` → Bronze

### Property 2: Tier is independent of elapsed time

**Validates: Requirements 1.4, 2.1**

For any fixed `retryCount` and any arbitrary `Duration`, the badge tier is identical. The method signature enforces this structurally (time is not an input parameter).

### Property 3: Tier monotonically degrades with increasing retry count

**Validates: Requirements 1.1, 1.2, 1.3**

For all `a <= b` where `a >= 0` and `b >= 0`: `tierFor(a).tier.index >= tierFor(b).tier.index` (Gold > Silver > Bronze in enum ordering). The tier never improves as retry count increases.

### Property 4: retryCardCount is monotonically non-decreasing during a session

**Validates: Requirements 3.1, 4.1**

Once a card enters the retry set, the `retryCardCount` counter only increases or stays the same — it never decreases within a single session.

## Testing Strategy

- **Unit tests** for `AchievementBadge.tierFor(retryCount)` covering boundary values (0, 1, 2, 3) and large values
- **Property-based test** verifying exhaustive/mutually-exclusive tier assignment and monotonic degradation
- **Widget test** for `PracticeSummaryScreen` confirming retry count stat is rendered
- **Integration check** that `retryCardCount` correctly accumulates during a mock session

# Tasks

- [x] 1. Add `retryCardCount` field (int, default 0) to `SessionState` in `lib/models/session_state.dart` and include it in `copyWith`
- [x] 2. Update `SessionNotifier.markBad()` in `lib/providers/session_provider.dart` to increment `retryCardCount` when a card is first added to `badCardIds`
- [x] 3. Pass `retryCardCount` through `_advance` method so it persists across state transitions
- [x] 4. Reset `retryCardCount` to 0 in `SessionNotifier.resetSession()` and `exitSession()`
- [x] 5. Replace `AchievementBadge.tierFor(int cardCount, Duration elapsed)` with `AchievementBadge.tierFor(int retryCount)` in `lib/models/achievement_badge.dart` implementing: 0 → Gold, 1-2 → Silver, 3+ → Bronze
- [x] 6. Remove `sessionTime` parameter from `AchievementBadgeWidget` in `lib/widgets/achievement_badge.dart`
- [x] 7. Update `PracticeSummaryScreen` in `lib/screens/practice_summary_screen.dart` to call `AchievementBadge.tierFor(session.retryCardCount)` and remove the `FutureBuilder` wrapper around badge calculation
- [x] 8. Add a fourth stat column to the summary screen showing retry count with `Icons.refresh_rounded`, displaying "Perfect!" when count is 0
- [x] 9. Write unit tests for `AchievementBadge.tierFor` covering boundary values (0, 1, 2, 3), negative input, and large values
- [x] 10. Run `flutter analyze` and existing tests to confirm no regressions

```json
{
  "waves": [
    [1, 5, 6],
    [2],
    [3],
    [4],
    [7, 9],
    [8],
    [10]
  ]
}
```

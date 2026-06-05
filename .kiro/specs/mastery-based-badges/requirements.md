# Requirements Document

## Introduction

Redesign the badge/achievement system in Articulately to reward mastery (fewer retries) rather than speed. The current speed-based approach is counterproductive for stuttering practice, where slow, controlled speech is the therapeutic goal. The timer remains visible as an informational stat but is fully decoupled from badge tier calculation.

## Glossary

- **Badge_System**: The component responsible for determining and displaying achievement badges after a practice session
- **Practice_Session**: A complete run through a set of flashcards including any retry rounds
- **Retry_Round**: A subsequent pass through cards previously marked "Not yet" during the initial round
- **Retry_Count**: The number of cards that required at least one retry round (tracked via `badCardIds` in SessionState)
- **Timer_Display**: The elapsed time indicator shown during practice and on the summary screen
- **Summary_Screen**: The post-session screen displaying badge, stats, and navigation options
- **Card**: A single flashcard in the practice deck that the user swipes right ("Got it") or left ("Not yet")

## Requirements

### Requirement 1: Badge Tier Calculation Based on Retry Count

**User Story:** As a practitioner, I want my badge to reflect how well I mastered the cards, so that I am rewarded for accuracy rather than speed.

#### Acceptance Criteria

1. WHEN a Practice_Session completes with a Retry_Count of 0, THE Badge_System SHALL award a Gold tier badge
2. WHEN a Practice_Session completes with a Retry_Count of 1 or 2, THE Badge_System SHALL award a Silver tier badge
3. WHEN a Practice_Session completes with a Retry_Count greater than 2, THE Badge_System SHALL award a Bronze tier badge
4. THE Badge_System SHALL determine badge tier using only the Retry_Count, without considering elapsed time

### Requirement 2: Timer Decoupled from Badge Calculation

**User Story:** As a practitioner, I want the timer to be purely informational, so that I do not feel pressured to rush through my speech exercises.

#### Acceptance Criteria

1. THE Badge_System SHALL calculate badge tier independently of the Timer_Display value
2. THE Timer_Display SHALL continue to record elapsed time during the Practice_Session
3. WHEN the Practice_Session completes, THE Summary_Screen SHALL display the elapsed time as an informational stat

### Requirement 3: Updated Badge Tier Method Signature

**User Story:** As a developer, I want the badge calculation method to accept retry count instead of time/card-count, so that the API reflects the new mastery-based logic.

#### Acceptance Criteria

1. THE Badge_System SHALL provide a method that accepts Retry_Count as input and returns the corresponding badge tier
2. THE Badge_System SHALL no longer require card count or elapsed duration as inputs for tier calculation

### Requirement 4: Summary Screen Displays Retry Information

**User Story:** As a practitioner, I want to see how many cards I retried on the summary screen, so that I can track my mastery progress.

#### Acceptance Criteria

1. WHEN the Practice_Session completes, THE Summary_Screen SHALL display the Retry_Count
2. WHEN the Retry_Count is 0, THE Summary_Screen SHALL indicate that all cards were mastered on the first pass
3. THE Summary_Screen SHALL continue to display time, card count, and difficulty level alongside the Retry_Count

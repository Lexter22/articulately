# Requirements Document

## Introduction

The Session Card Count Selector feature adds an intermediate screen between category selection and flashcard practice that lets users choose how many flashcards they want in a session. Instead of always practicing with every available card for a category+difficulty combination, users can select from preset options (Quick, Standard, All) to control session length. Cards are shuffled before being trimmed to the selected count, ensuring varied practice each time.

## Glossary

- **Card_Count_Selector_Screen**: The screen displayed after category selection that presents card count options to the user
- **Session**: A single practice run consisting of a set of flashcards for a given category and difficulty
- **Preset_Option**: A predefined card count choice presented to the user (Quick, Standard, or All)
- **Available_Cards**: The complete set of flashcards for the selected category and difficulty combination
- **Shuffled_Deck**: The Available_Cards after random reordering
- **Trimmed_Deck**: The Shuffled_Deck reduced to the user-selected card count
- **App_Router**: The go_router navigation system that manages screen transitions
- **Session_Notifier**: The Riverpod state notifier that manages flashcard session state

## Requirements

### Requirement 1: Display Card Count Selector Screen

**User Story:** As a user, I want to see a card count selection screen after choosing a category, so that I can decide how many flashcards to practice before starting.

#### Acceptance Criteria

1. WHEN the user selects a category from the CategoryListScreen, THE App_Router SHALL navigate to the Card_Count_Selector_Screen, passing the selected category identifier and difficulty level as route parameters
2. THE Card_Count_Selector_Screen SHALL display the selected category name and difficulty level as text labels
3. THE Card_Count_Selector_Screen SHALL display a prompt asking "How many flashcards?"
4. THE Card_Count_Selector_Screen SHALL display three Preset_Option buttons: "Quick (5 cards)", "Standard (10 cards)", and "All"
5. THE Card_Count_Selector_Screen SHALL display the total number of Available_Cards for the selected category and difficulty in the format "{count} cards available"
6. WHILE the Available_Cards count is being loaded, THE Card_Count_Selector_Screen SHALL display a loading indicator and disable all Preset_Option buttons
7. IF the Available_Cards count fails to load, THEN THE Card_Count_Selector_Screen SHALL display an error message indicating the cards could not be loaded and provide a retry option

### Requirement 2: Handle Preset Option Selection

**User Story:** As a user, I want to select a preset card count option, so that I can start a practice session with my preferred number of cards.

#### Acceptance Criteria

1. WHEN the user selects the "Quick" Preset_Option, THE Card_Count_Selector_Screen SHALL set the selected card count to 5 and pass it to the Session_Notifier along with the Trimmed_Deck
2. WHEN the user selects the "Standard" Preset_Option, THE Card_Count_Selector_Screen SHALL set the selected card count to 10 and pass it to the Session_Notifier along with the Trimmed_Deck
3. WHEN the user selects the "All" Preset_Option, THE Card_Count_Selector_Screen SHALL set the selected card count to the total number of Available_Cards and pass it to the Session_Notifier along with the Trimmed_Deck
4. WHEN the user selects a Preset_Option and the Session_Notifier has received the Trimmed_Deck, THE App_Router SHALL navigate to the FlashcardScreen with the current categoryId and difficulty as route parameters
5. IF session initiation fails after the user selects a Preset_Option, THEN THE Card_Count_Selector_Screen SHALL remain on screen and display an error message indicating the session could not be started

### Requirement 3: Shuffle and Trim Cards

**User Story:** As a user, I want the cards to be shuffled before being limited to my chosen count, so that I get a different subset of cards each session.

#### Acceptance Criteria

1. WHEN a Preset_Option is selected, THE Card_Count_Selector_Screen SHALL shuffle the Available_Cards into a random order to produce the Shuffled_Deck
2. IF the selected count is less than the total number of Available_Cards, THEN THE Card_Count_Selector_Screen SHALL take the first N cards from the Shuffled_Deck to produce the Trimmed_Deck, where N is the selected count
3. IF the selected count equals or exceeds the total number of Available_Cards, THEN THE Card_Count_Selector_Screen SHALL use the entire Shuffled_Deck as the Trimmed_Deck
4. WHEN the Session_Notifier starts a session, THE Session_Notifier SHALL receive the Trimmed_Deck as the active deck for the session

### Requirement 4: Handle Insufficient Cards

**User Story:** As a user, I want to be informed when fewer cards are available than my chosen preset, so that I understand why I received fewer cards than expected.

#### Acceptance Criteria

1. WHILE the number of Available_Cards is fewer than 5, THE Card_Count_Selector_Screen SHALL disable the "Quick" Preset_Option
2. WHILE the number of Available_Cards is fewer than 10, THE Card_Count_Selector_Screen SHALL disable the "Standard" Preset_Option
3. WHILE the number of Available_Cards is zero, THE Card_Count_Selector_Screen SHALL disable all Preset_Options and display a message "No cards available for this combination"
4. WHILE at least one Available_Card exists, THE Card_Count_Selector_Screen SHALL enable the "All" Preset_Option
5. WHILE a Preset_Option is disabled due to insufficient Available_Cards, THE Card_Count_Selector_Screen SHALL display the number of Available_Cards on the disabled option to indicate why it is unavailable

### Requirement 5: Provide Navigation Back

**User Story:** As a user, I want to go back to the category list if I change my mind, so that I can pick a different category.

#### Acceptance Criteria

1. THE Card_Count_Selector_Screen SHALL display a back button as the leading widget in the app bar
2. WHEN the user presses the back button, THE App_Router SHALL navigate to the CategoryListScreen with the same difficulty value that was passed to the Card_Count_Selector_Screen
3. WHEN the user triggers the system back navigation gesture, THE App_Router SHALL navigate to the CategoryListScreen with the same difficulty value that was passed to the Card_Count_Selector_Screen

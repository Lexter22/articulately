# Product: Articulately

Articulately is a speech articulation practice app. Users improve verbal clarity, pronunciation, and speaking confidence through flashcard-based exercises.

## Core Loop

1. User selects a difficulty level (Easy, Medium, Hard, or Random)
2. User picks a category of flashcards
3. User optionally selects how many cards to practice
4. Cards are presented full-screen; swipe right = "got it", swipe left = "needs practice"
5. Failed cards enter a retry round that loops until mastered or the user exits
6. Session ends with a summary showing time, card count, and an achievement badge (Gold ≤5s/card, Silver ≤10s/card, Bronze >10s/card)

## Target Users

- Speech therapy patients
- Public speakers and presenters
- Language learners
- Voice actors and performers
- Anyone improving spoken clarity

## Key Capabilities

- Offline-ready with repository pattern (Supabase remote + local fallback)
- Admin panel for content management (behind Supabase Auth)
- Live practice timer
- Achievement badges based on speed
- Category and difficulty-based content organisation

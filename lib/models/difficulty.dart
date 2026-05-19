enum Difficulty { easy, medium, hard }

Difficulty nextDifficulty(Difficulty current) {
  switch (current) {
    case Difficulty.easy:
      return Difficulty.medium;
    case Difficulty.medium:
      return Difficulty.hard;
    case Difficulty.hard:
      return Difficulty.hard;
  }
}

extension DifficultyParsing on Difficulty {
  static Difficulty fromString(String value) {
    return Difficulty.values.firstWhere(
      (d) => d.name == value,
      orElse: () => Difficulty.easy,
    );
  }
}

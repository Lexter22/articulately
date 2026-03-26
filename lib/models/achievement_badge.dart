enum BadgeTier { bronze, silver, gold }

class AchievementBadge {
  final BadgeTier tier;
  final String label;

  const AchievementBadge({
    required this.tier,
    required this.label,
  });

  static AchievementBadge tierFor(int cardCount, Duration elapsed) {
    if (cardCount <= 0) {
      return const AchievementBadge(tier: BadgeTier.bronze, label: 'Bronze');
    }
    final avgSeconds = elapsed.inSeconds / cardCount;
    if (avgSeconds <= 5) {
      return const AchievementBadge(tier: BadgeTier.gold, label: 'Gold');
    } else if (avgSeconds <= 10) {
      return const AchievementBadge(tier: BadgeTier.silver, label: 'Silver');
    } else {
      return const AchievementBadge(tier: BadgeTier.bronze, label: 'Bronze');
    }
  }
}

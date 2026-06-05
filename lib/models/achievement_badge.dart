enum BadgeTier { bronze, silver, gold }

class AchievementBadge {
  final BadgeTier tier;
  final String label;

  const AchievementBadge({
    required this.tier,
    required this.label,
  });

  static AchievementBadge tierFor(int retryCount) {
    if (retryCount <= 0) {
      return const AchievementBadge(tier: BadgeTier.gold, label: 'Gold');
    } else if (retryCount <= 2) {
      return const AchievementBadge(tier: BadgeTier.silver, label: 'Silver');
    } else {
      return const AchievementBadge(tier: BadgeTier.bronze, label: 'Bronze');
    }
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:articulately/models/achievement_badge.dart';

void main() {
  group('AchievementBadge.tierFor', () {
    test('retryCount = 0 returns Gold tier', () {
      final badge = AchievementBadge.tierFor(0);
      expect(badge.tier, BadgeTier.gold);
      expect(badge.label, 'Gold');
    });

    test('retryCount = 1 returns Silver tier', () {
      final badge = AchievementBadge.tierFor(1);
      expect(badge.tier, BadgeTier.silver);
      expect(badge.label, 'Silver');
    });

    test('retryCount = 2 returns Silver tier (upper boundary)', () {
      final badge = AchievementBadge.tierFor(2);
      expect(badge.tier, BadgeTier.silver);
      expect(badge.label, 'Silver');
    });

    test('retryCount = 3 returns Bronze tier (lower boundary)', () {
      final badge = AchievementBadge.tierFor(3);
      expect(badge.tier, BadgeTier.bronze);
      expect(badge.label, 'Bronze');
    });

    test('negative retryCount (-1) returns Gold tier (defensive)', () {
      final badge = AchievementBadge.tierFor(-1);
      expect(badge.tier, BadgeTier.gold);
      expect(badge.label, 'Gold');
    });

    test('large retryCount (100) returns Bronze tier', () {
      final badge = AchievementBadge.tierFor(100);
      expect(badge.tier, BadgeTier.bronze);
      expect(badge.label, 'Bronze');
    });

    test('large retryCount (1000) returns Bronze tier', () {
      final badge = AchievementBadge.tierFor(1000);
      expect(badge.tier, BadgeTier.bronze);
      expect(badge.label, 'Bronze');
    });
  });
}

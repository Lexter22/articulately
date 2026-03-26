import 'package:flutter/material.dart';
import '../models/achievement_badge.dart';
import '../theme.dart';

class AchievementBadgeWidget extends StatefulWidget {
  final AchievementBadge badge;
  final Duration sessionTime;

  const AchievementBadgeWidget({
    super.key,
    required this.badge,
    required this.sessionTime,
  });

  @override
  State<AchievementBadgeWidget> createState() => _AchievementBadgeWidgetState();
}

class _AchievementBadgeWidgetState extends State<AchievementBadgeWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _BadgeStyle get _style {
    switch (widget.badge.tier) {
      case BadgeTier.gold:
        return _BadgeStyle(
          icon: Icons.emoji_events_rounded,
          color: const Color(0xFFFFD900),
          borderColor: const Color(0xFFC9A800),
          bgColor: const Color(0xFFFFFBE6),
          label: '🥇 Gold',
        );
      case BadgeTier.silver:
        return _BadgeStyle(
          icon: Icons.military_tech_rounded,
          color: const Color(0xFF9E9E9E),
          borderColor: const Color(0xFF757575),
          bgColor: const Color(0xFFF5F5F5),
          label: '🥈 Silver',
        );
      case BadgeTier.bronze:
        return _BadgeStyle(
          icon: Icons.workspace_premium_rounded,
          color: const Color(0xFFCD7F32),
          borderColor: const Color(0xFF8B5E3C),
          bgColor: const Color(0xFFFFF3E0),
          label: '🥉 Bronze',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = _style;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacing32,
            vertical: AppTheme.spacing24,
          ),
          decoration: BoxDecoration(
            color: s.bgColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: s.borderColor.withValues(alpha: 0.4), width: 2),
            boxShadow: [
              BoxShadow(
                color: s.color.withValues(alpha: 0.2),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(s.icon, color: s.color, size: 56),
              const SizedBox(height: AppTheme.spacing8),
              Text(
                s.label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: s.borderColor,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BadgeStyle {
  final IconData icon;
  final Color color;
  final Color borderColor;
  final Color bgColor;
  final String label;
  const _BadgeStyle({
    required this.icon,
    required this.color,
    required this.borderColor,
    required this.bgColor,
    required this.label,
  });
}

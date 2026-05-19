import 'package:flutter/material.dart';
import '../models/difficulty.dart';
import '../theme.dart';
import 'pressable.dart';

class DifficultyButton extends StatelessWidget {
  final Difficulty difficulty;
  final VoidCallback onTap;

  const DifficultyButton({
    super.key,
    required this.difficulty,
    required this.onTap,
  });

  _DifficultyStyle get _style {
    switch (difficulty) {
      case Difficulty.easy:
        return _DifficultyStyle(
          label: 'Easy',
          subtitle: 'Perfect to start',
          icon: Icons.sentiment_satisfied_alt_rounded,
          bgColor: AppTheme.colorPrimary,
          borderColor: AppTheme.colorPrimaryDark,
          textColor: AppTheme.colorTextOnColor,
        );
      case Difficulty.medium:
        return _DifficultyStyle(
          label: 'Medium',
          subtitle: 'Step it up',
          icon: Icons.local_fire_department_rounded,
          bgColor: AppTheme.colorBlue,
          borderColor: AppTheme.colorBlueDark,
          textColor: AppTheme.colorTextOnColor,
        );
      case Difficulty.hard:
        return _DifficultyStyle(
          label: 'Hard',
          subtitle: 'For the brave',
          icon: Icons.bolt_rounded,
          bgColor: AppTheme.colorCoral,
          borderColor: AppTheme.colorCoralDark,
          textColor: AppTheme.colorTextOnColor,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = _style;
    return Pressable(
      onTap: onTap,
      scaleTo: 0.95,
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: AppTheme.spacing16,
            horizontal: AppTheme.spacing16,
          ),
          decoration: BoxDecoration(
            color: s.bgColor,
            borderRadius: BorderRadius.circular(16),
            border: Border(
              bottom: BorderSide(color: s.borderColor, width: 4),
            ),
            boxShadow: [
              BoxShadow(
                color: s.borderColor.withValues(alpha: 0.4),
                blurRadius: 0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spacing8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(s.icon, color: s.textColor, size: 26),
              ),
              const SizedBox(width: AppTheme.spacing12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.label,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: s.textColor,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  Text(
                    s.subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: s.textColor.withValues(alpha: 0.85),
                        ),
                  ),
                ],
              ),
              const Spacer(),
              Icon(Icons.chevron_right_rounded, color: s.textColor.withValues(alpha: 0.7), size: 22),
            ],
          ),
        ),
    );
  }
}

class _DifficultyStyle {
  final String label;
  final String subtitle;
  final IconData icon;
  final Color bgColor;
  final Color borderColor;
  final Color textColor;

  const _DifficultyStyle({
    required this.label,
    required this.subtitle,
    required this.icon,
    required this.bgColor,
    required this.borderColor,
    required this.textColor,
  });
}

import 'package:flutter/material.dart';
import '../theme.dart';

/// Formats a [Duration] as "M:SS min" (e.g. "1:05 min", "0:45 min").
String formatDuration(Duration d) {
  final totalSeconds = d.inSeconds;
  final minutes = totalSeconds ~/ 60;
  final seconds = totalSeconds % 60;
  final paddedSeconds = seconds.toString().padLeft(2, '0');
  return '$minutes:$paddedSeconds min';
}

class PracticeTimerDisplay extends StatelessWidget {
  final Duration elapsed;

  const PracticeTimerDisplay({
    super.key,
    required this.elapsed,
  });

  /// Static helper so other widgets (e.g. PracticeSummaryScreen) can format
  /// a duration without instantiating the widget.
  static String format(Duration d) => formatDuration(d);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacing12,
        vertical: AppTheme.spacing4,
      ),
      decoration: BoxDecoration(
        color: AppTheme.colorBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.colorBlue.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.timer_rounded, color: AppTheme.colorBlue, size: 14),
          const SizedBox(width: 4),
          Text(
            formatDuration(elapsed),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppTheme.colorBlue,
            ),
          ),
        ],
      ),
    );
  }
}

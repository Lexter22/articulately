import 'package:flutter/material.dart';
import '../theme.dart';

class SessionProgressIndicator extends StatelessWidget {
  final int currentIndex;
  final int total;

  const SessionProgressIndicator({
    super.key,
    required this.currentIndex,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final progress = total > 0 ? (currentIndex + 1) / total : 0.0;

    return Row(
      children: [
        Text(
          '${currentIndex + 1}/$total',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.colorTextPrimary,
              ),
        ),
        const SizedBox(width: AppTheme.spacing8),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: AppTheme.colorBorder,
              valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.colorPrimary),
            ),
          ),
        ),
      ],
    );
  }
}

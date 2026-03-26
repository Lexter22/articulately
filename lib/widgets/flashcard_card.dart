import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../theme.dart';

class FlashcardCard extends StatelessWidget {
  final Flashcard flashcard;

  const FlashcardCard({
    super.key,
    required this.flashcard,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppTheme.spacing32),
        decoration: BoxDecoration(
          color: AppTheme.colorSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.colorBorder, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing12),
              decoration: BoxDecoration(
                color: AppTheme.colorPrimary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.record_voice_over_rounded,
                color: AppTheme.colorPrimary,
                size: 32,
              ),
            ),
            const SizedBox(height: AppTheme.spacing24),
            Text(
              flashcard.text,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: AppTheme.colorTextPrimary,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

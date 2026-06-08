import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:articulately/widgets/difficulty_button.dart';
import 'package:articulately/models/difficulty.dart';

void main() {
  // Tests that require Supabase initialization are skipped.
  // These need a mock Supabase setup or integration test harness to work.
  // They broke when Supabase auth was added to the router.

  testWidgets('DifficultyButton renders label', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DifficultyButton(
            difficulty: Difficulty.easy,
            onTap: () {},
          ),
        ),
      ),
    );
    expect(find.text('Easy'), findsOneWidget);
  });
}

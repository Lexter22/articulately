import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:articulately/app.dart';
import 'package:articulately/screens/session_complete_screen.dart';
import 'package:articulately/screens/practice_summary_screen.dart';
import 'package:articulately/widgets/difficulty_button.dart';
import 'package:articulately/models/difficulty.dart';

void main() {
  testWidgets('App renders without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));
    await tester.pumpAndSettle();
    expect(find.text('Articulately'), findsOneWidget);
  });

  testWidgets('HomeScreen renders all 4 difficulty buttons', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));
    await tester.pumpAndSettle();

    expect(find.text('Easy'), findsOneWidget);
    expect(find.text('Medium'), findsOneWidget);
    expect(find.text('Hard'), findsOneWidget);
    expect(find.text('Random'), findsOneWidget);
  });

  testWidgets('HomeScreen shows tagline', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));
    await tester.pumpAndSettle();

    expect(find.text('Articulate with Confidence'), findsOneWidget);
  });

  testWidgets('SessionCompleteScreen renders checkmark and messages', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: SessionCompleteScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.check_circle), findsOneWidget);
    expect(find.text('Set Complete!'), findsOneWidget);
    expect(find.text('Great job!'), findsOneWidget);
    expect(find.text('Check summary'), findsOneWidget);
  });

  testWidgets('PracticeSummaryScreen renders all 3 action buttons', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: PracticeSummaryScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Try next level'), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
  });

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

  testWidgets('HomeScreen renders on small screen without overflow', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(350, 700);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const ProviderScope(child: App()));
    await tester.pumpAndSettle();

    expect(find.text('Articulately'), findsOneWidget);
    expect(find.text('Easy'), findsOneWidget);
  });
}

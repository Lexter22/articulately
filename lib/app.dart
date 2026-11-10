import 'package:flutter/material.dart';
import 'router.dart';
import 'theme.dart';

/// Max content width so the phone-first layout stays readable on
/// tablets and desktop browsers.
const double _kMaxContentWidth = 520;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Articulately',
      theme: AppTheme.light(),
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ColoredBox(
          color: AppTheme.colorBackground,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _kMaxContentWidth),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

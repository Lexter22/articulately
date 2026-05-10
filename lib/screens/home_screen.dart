import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../models/difficulty.dart';
import '../theme.dart';
import '../widgets/app_logo.dart';
import '../widgets/difficulty_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _onDifficultyTapped(BuildContext context, Difficulty? difficulty) {
    final Difficulty resolved;
    if (difficulty == null) {
      final options = [Difficulty.easy, Difficulty.medium, Difficulty.hard];
      resolved = options[Random().nextInt(options.length)];
    } else {
      resolved = difficulty;
    }
    context.push('/categories?difficulty=${resolved.name}');
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) SystemNavigator.pop();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacing24,
              vertical: AppTheme.spacing32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppTheme.spacing32),
                // Hero section
                Container(
                  padding: const EdgeInsets.all(AppTheme.spacing24),
                  decoration: BoxDecoration(
                    color: AppTheme.colorPrimary,
                    borderRadius: BorderRadius.circular(24),
                    border: const Border(
                      bottom: BorderSide(
                        color: AppTheme.colorPrimaryDark,
                        width: 4,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppTheme.spacing16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const AppLogo(size: 48),
                      ),
                      const SizedBox(height: AppTheme.spacing16),
                      Text(
                        'Articulately',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayLarge
                            ?.copyWith(
                              color: AppTheme.colorTextOnColor,
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                      const SizedBox(height: AppTheme.spacing4),
                      Text(
                        'Articulate with Confidence',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.colorTextOnColor.withValues(
                            alpha: 0.85,
                          ),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppTheme.spacing32),
                // Section label
                Row(
                  children: [
                    const Icon(
                      Icons.tune_rounded,
                      size: 18,
                      color: AppTheme.colorTextSecondary,
                    ),
                    const SizedBox(width: AppTheme.spacing8),
                    Text(
                      'Choose your difficulty',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.colorTextSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacing12),
                // Difficulty buttons
                DifficultyButton(
                  difficulty: Difficulty.easy,
                  onTap: () => _onDifficultyTapped(context, Difficulty.easy),
                ),
                const SizedBox(height: AppTheme.spacing12),
                DifficultyButton(
                  difficulty: Difficulty.medium,
                  onTap: () => _onDifficultyTapped(context, Difficulty.medium),
                ),
                const SizedBox(height: AppTheme.spacing12),
                DifficultyButton(
                  difficulty: Difficulty.hard,
                  onTap: () => _onDifficultyTapped(context, Difficulty.hard),
                ),
                const SizedBox(height: AppTheme.spacing12),
                _RandomButton(onTap: () => _onDifficultyTapped(context, null)),
                const SizedBox(height: AppTheme.spacing32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RandomButton extends StatefulWidget {
  final VoidCallback onTap;
  const _RandomButton({required this.onTap});

  @override
  State<_RandomButton> createState() => _RandomButtonState();
}

class _RandomButtonState extends State<_RandomButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) => _controller.forward();
  void _onTapUp(TapUpDetails _) {
    _controller.reverse();
    widget.onTap();
  }

  void _onTapCancel() => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: AppTheme.spacing16,
            horizontal: AppTheme.spacing16,
          ),
          decoration: BoxDecoration(
            color: AppTheme.colorYellow,
            borderRadius: BorderRadius.circular(16),
            border: const Border(
              bottom: BorderSide(color: AppTheme.colorYellowDark, width: 4),
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.colorYellowDark.withValues(alpha: 0.4),
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
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.shuffle_rounded,
                  color: AppTheme.colorTextPrimary,
                  size: 26,
                ),
              ),
              const SizedBox(width: AppTheme.spacing12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Random',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.colorTextPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'Surprise me!',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.colorTextPrimary.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Icon(
                Icons.chevron_right_rounded,
                color: AppTheme.colorTextPrimary.withValues(alpha: 0.6),
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

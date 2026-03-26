import 'package:flutter/material.dart';
import '../theme.dart';

enum NavDirection { prev, next }

class NavArrowButton extends StatefulWidget {
  final NavDirection direction;
  final VoidCallback? onTap;

  const NavArrowButton({
    super.key,
    required this.direction,
    required this.onTap,
  });

  @override
  State<NavArrowButton> createState() => _NavArrowButtonState();
}

class _NavArrowButtonState extends State<NavArrowButton>
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
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.88).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    if (widget.onTap != null) _controller.forward();
  }
  void _onTapUp(TapUpDetails _) {
    _controller.reverse();
    widget.onTap?.call();
  }
  void _onTapCancel() => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onTap != null;
    final isPrev = widget.direction == NavDirection.prev;

    return GestureDetector(
      onTapDown: isEnabled ? _onTapDown : null,
      onTapUp: isEnabled ? _onTapUp : null,
      onTapCancel: isEnabled ? _onTapCancel : null,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacing16,
            vertical: AppTheme.spacing12,
          ),
          decoration: BoxDecoration(
            color: isEnabled ? AppTheme.colorSurface : AppTheme.colorBackground,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isEnabled ? AppTheme.colorBorder : AppTheme.colorBorder.withValues(alpha: 0.5),
              width: 2,
            ),
            boxShadow: isEnabled
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isPrev) ...[
                Icon(
                  Icons.arrow_back_rounded,
                  color: isEnabled ? AppTheme.colorTextPrimary : AppTheme.colorBorder,
                  size: 20,
                ),
                const SizedBox(width: AppTheme.spacing4),
                Text(
                  'Back',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: isEnabled ? AppTheme.colorTextPrimary : AppTheme.colorBorder,
                  ),
                ),
              ] else ...[
                Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: isEnabled ? AppTheme.colorPrimary : AppTheme.colorBorder,
                  ),
                ),
                const SizedBox(width: AppTheme.spacing4),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: isEnabled ? AppTheme.colorPrimary : AppTheme.colorBorder,
                  size: 20,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

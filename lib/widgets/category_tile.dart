import 'package:flutter/material.dart';
import '../models/category.dart';
import '../theme.dart';

// Maps category id → icon + accent color
const _kCategoryMeta = {
  'daily-warmups': _CategoryMeta(Icons.wb_sunny_rounded, Color(0xFFFF9600)),
  'hissing-snack': _CategoryMeta(Icons.air_rounded, Color(0xFF1CB0F6)),
  'popping-plosives': _CategoryMeta(Icons.bubble_chart_rounded, Color(0xFFFF4B4B)),
  'smooth-gliders': _CategoryMeta(Icons.waves_rounded, Color(0xFF58CC02)),
  'tongue-busters': _CategoryMeta(Icons.flash_on_rounded, Color(0xFFCE82FF)),
};

class _CategoryMeta {
  final IconData icon;
  final Color color;
  const _CategoryMeta(this.icon, this.color);
}

class CategoryTile extends StatefulWidget {
  final Category category;
  final VoidCallback onTap;

  const CategoryTile({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile>
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
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
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
    final meta = _kCategoryMeta[widget.category.id] ??
        const _CategoryMeta(Icons.record_voice_over_rounded, AppTheme.colorPrimary);
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppTheme.spacing16),
          decoration: BoxDecoration(
            color: AppTheme.colorSurface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.colorBorder, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: meta.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(meta.icon, color: meta.color, size: 28),
              ),
              const SizedBox(width: AppTheme.spacing12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.category.name, style: textTheme.titleMedium),
                    const SizedBox(height: AppTheme.spacing4),
                    Text(widget.category.subtitle, style: textTheme.bodySmall),
                  ],
                ),
              ),
              const SizedBox(width: AppTheme.spacing8),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: meta.color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_forward_rounded, color: meta.color, size: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

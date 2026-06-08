import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/difficulty.dart';
import '../models/flashcard.dart';
import '../models/preset_option.dart';
import '../providers/content_provider.dart';
import '../providers/session_provider.dart';
import '../theme.dart';
import '../utils/deck_preparation.dart';

class CardCountSelectorScreen extends ConsumerStatefulWidget {
  final String categoryId;
  final String difficulty;

  const CardCountSelectorScreen({
    super.key,
    required this.categoryId,
    required this.difficulty,
  });

  @override
  ConsumerState<CardCountSelectorScreen> createState() =>
      _CardCountSelectorScreenState();
}

class _CardCountSelectorScreenState
    extends ConsumerState<CardCountSelectorScreen> {
  List<Flashcard>? _availableCards;
  bool _isLoading = true;
  String? _errorMessage;
  String? _categoryName;

  Difficulty _parseDifficulty(String value) =>
      DifficultyParsing.fromString(value);

  @override
  void initState() {
    super.initState();
    _fetchCards();
  }

  Future<void> _fetchCards() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final repo = ref.read(contentRepositoryProvider);
      final diff = _parseDifficulty(widget.difficulty);

      // Fetch categories to get the category name
      final categories = await repo.getCategories();
      final category = categories.where((c) => c.id == widget.categoryId).firstOrNull;
      _categoryName = category?.name ?? widget.categoryId;

      // Fetch flashcards
      final flashcardSet = await repo.getFlashcardSet(widget.categoryId, diff);

      if (!mounted) return;

      setState(() {
        _availableCards = flashcardSet?.cards ?? [];
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = 'Could not load cards. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => _navigateBack(),
          tooltip: 'Back',
        ),
        automaticallyImplyLeading: false,
        title: const Text('Select Card Count'),
        titleTextStyle: Theme.of(context).textTheme.headlineMedium,
      ),
      body: SafeArea(
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_isLoading) {
      return _buildLoadingState(context);
    }

    if (_errorMessage != null) {
      return _buildErrorState(context);
    }

    return _buildSuccessState(context);
  }

  Widget _buildLoadingState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacing16,
        vertical: AppTheme.spacing16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppTheme.spacing24),
          const Center(child: CircularProgressIndicator()),
          const SizedBox(height: AppTheme.spacing24),
          Text(
            'How many flashcards?',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spacing24),
          // Disabled preset buttons during loading
          ...defaultPresets.map(
            (preset) => Padding(
              padding: const EdgeInsets.only(bottom: AppTheme.spacing12),
              child: _PresetButton(
                preset: preset,
                enabled: false,
                onTap: null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacing16,
        vertical: AppTheme.spacing24,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.wifi_off_rounded,
            size: 48,
            color: AppTheme.colorTextSecondary,
          ),
          const SizedBox(height: AppTheme.spacing12),
          Text(
            _errorMessage!,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spacing12),
          OutlinedButton.icon(
            onPressed: _fetchCards,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessState(BuildContext context) {
    final cards = _availableCards!;
    final cardCount = cards.length;
    final diff = _parseDifficulty(widget.difficulty);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacing16,
        vertical: AppTheme.spacing16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Category name and difficulty
          Text(
            _categoryName ?? widget.categoryId,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spacing4),
          Text(
            diff.name[0].toUpperCase() + diff.name.substring(1),
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spacing16),
          // Card count
          Text(
            '$cardCount cards available',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spacing24),
          // Prompt
          Text(
            'How many flashcards?',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spacing16),
          // No cards message
          if (cardCount == 0)
            Padding(
              padding: const EdgeInsets.only(bottom: AppTheme.spacing16),
              child: Text(
                'No cards available for this combination',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.colorCoral,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          // Preset buttons
          ...defaultPresets.map(
            (preset) {
              final enabled = isPresetEnabled(cardCount, preset.cardCount);
              return Padding(
                padding: const EdgeInsets.only(bottom: AppTheme.spacing12),
                child: _PresetButton(
                  preset: preset,
                  enabled: enabled,
                  availableCount: cardCount,
                  onTap: enabled ? () => _onPresetSelected(preset) : null,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _onPresetSelected(PresetOption preset) {
    final count = preset.cardCount ?? _availableCards!.length;
    final trimmedDeck = prepareDeck(_availableCards!, count);

    try {
      final difficulty = _parseDifficulty(widget.difficulty);
      ref.read(sessionProvider.notifier).startSessionWithDeck(
            difficulty,
            widget.categoryId,
            trimmedDeck,
          );
      context.push(
        '/flashcard?categoryId=${widget.categoryId}&difficulty=${widget.difficulty}',
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not start session')),
      );
    }
  }

  void _navigateBack() {
    context.pop();
  }
}

class _PresetButton extends StatelessWidget {
  final PresetOption preset;
  final bool enabled;
  final int? availableCount;
  final VoidCallback? onTap;

  const _PresetButton({
    required this.preset,
    required this.enabled,
    this.availableCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              enabled ? AppTheme.colorPrimary : AppTheme.colorBorder,
          foregroundColor:
              enabled ? AppTheme.colorTextOnColor : AppTheme.colorTextSecondary,
          padding: const EdgeInsets.symmetric(
            vertical: AppTheme.spacing16,
            horizontal: AppTheme.spacing16,
          ),
        ),
        child: Column(
          children: [
            Text(
              preset.label,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppTheme.spacing4),
            Text(
              _subtitleText,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String get _subtitleText {
    if (!enabled && availableCount != null && preset.cardCount != null) {
      return '${preset.subtitle} (only $availableCount available)';
    }
    return preset.subtitle;
  }
}

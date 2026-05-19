import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/difficulty.dart';
import '../theme.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final _client = Supabase.instance.client;
  final _textController = TextEditingController();

  List<Map<String, dynamic>> _categories = [];
  List<Map<String, dynamic>> _flashcards = [];
  String? _selectedCategoryId;
  Difficulty _selectedDifficulty = Difficulty.easy;
  bool _loading = false;
  bool _saving = false;
  String? _inputError;
  bool _addedSuccess = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _loading = true);
    try {
      final categories = await _client
          .from('categories')
          .select('id, name')
          .order('name');
      setState(() {
        _categories = List<Map<String, dynamic>>.from(categories);
        if (_categories.isNotEmpty) {
          _selectedCategoryId ??= _categories.first['id'] as String;
        }
      });
      await _loadFlashcards();
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _loadFlashcards() async {
    if (_selectedCategoryId == null) return;
    final data = await _client
        .from('flashcards')
        .select('id, text, difficulty')
        .eq('category_id', _selectedCategoryId!)
        .eq('difficulty', _selectedDifficulty.name)
        .order('id');
    if (mounted) {
      setState(() => _flashcards = List<Map<String, dynamic>>.from(data));
    }
  }

  void _validateInput() {
    final text = _textController.text.trim();
    String? error;
    if (text.isEmpty) {
      error = 'Flashcard text cannot be empty.';
    } else if (text.length < 10) {
      error = 'Too short — add at least 10 characters.';
    } else if (text.length > 300) {
      error = 'Too long — keep it under 300 characters.';
    } else if (_flashcards.any((c) => (c['text'] as String).toLowerCase() == text.toLowerCase())) {
      error = 'This flashcard already exists in this set.';
    }
    setState(() => _inputError = error);
  }

  Future<void> _addFlashcard() async {
    _validateInput();
    if (_inputError != null || _selectedCategoryId == null) return;
    setState(() { _saving = true; _addedSuccess = false; });
    try {
      await _client.from('flashcards').insert({
        'id': '${_selectedCategoryId!.substring(0, 2)}-${_selectedDifficulty.name[0]}-${DateTime.now().millisecondsSinceEpoch}',
        'text': _textController.text.trim(),
        'category_id': _selectedCategoryId,
        'difficulty': _selectedDifficulty.name,
      });
      _textController.clear();
      setState(() { _inputError = null; _addedSuccess = true; });
      await _loadFlashcards();
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) setState(() => _addedSuccess = false);
    } on PostgrestException catch (e) {
      if (mounted) setState(() => _inputError = e.message);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _deleteFlashcard(String id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete flashcard?',
            style: TextStyle(fontWeight: FontWeight.w800)),
        content: const Text('This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.colorCoral,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await _client.from('flashcards').delete().eq('id', id);
    await _loadFlashcards();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Text('Flashcard deleted.'),
            ],
          ),
          backgroundColor: AppTheme.colorCoral,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Color _difficultyColor(Difficulty d) {
    switch (d) {
      case Difficulty.easy:
        return AppTheme.colorPrimary;
      case Difficulty.medium:
        return AppTheme.colorBlue;
      case Difficulty.hard:
        return AppTheme.colorCoral;
    }
  }

  @override
  Widget build(BuildContext context) {
    final diffColor = _difficultyColor(_selectedDifficulty);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.go('/'),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacing8,
                vertical: AppTheme.spacing4,
              ),
              decoration: BoxDecoration(
                color: AppTheme.colorPrimary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'ADMIN',
                style: TextStyle(
                  color: AppTheme.colorPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(width: AppTheme.spacing8),
            const Text('Content Manager'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Sign out',
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  title: const Text('Sign out?',
                      style: TextStyle(fontWeight: FontWeight.w800)),
                  content: const Text('You will need to sign in again to manage content.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.colorCoral,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Sign out'),
                    ),
                  ],
                ),
              );
              if (confirmed != true) return;
              await _client.auth.signOut();
              if (mounted) context.go('/');
            },
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: [
                  // Top panel
                  Container(
                    color: AppTheme.colorSurface,
                    padding: const EdgeInsets.all(AppTheme.spacing16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Category picker
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.spacing16,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.colorBackground,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                                color: AppTheme.colorBorder, width: 2),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedCategoryId,
                              isExpanded: true,
                              icon: const Icon(Icons.keyboard_arrow_down_rounded),
                              style: const TextStyle(
                                color: AppTheme.colorTextPrimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                              items: _categories.map((c) {
                                return DropdownMenuItem(
                                  value: c['id'] as String,
                                  child: Text(c['name'] as String),
                                );
                              }).toList(),
                              onChanged: (val) {
                                setState(() => _selectedCategoryId = val);
                                _loadFlashcards();
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: AppTheme.spacing12),
                        // Difficulty tabs
                        Row(
                          children: Difficulty.values.map((d) {
                            final selected = _selectedDifficulty == d;
                            final color = _difficultyColor(d);
                            return Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() => _selectedDifficulty = d);
                                  _loadFlashcards();
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  margin: EdgeInsets.only(
                                    right: d != Difficulty.hard
                                        ? AppTheme.spacing8
                                        : 0,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: AppTheme.spacing12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: selected
                                        ? color.withValues(alpha: 0.12)
                                        : AppTheme.colorBackground,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: selected
                                          ? color
                                          : AppTheme.colorBorder,
                                      width: selected ? 2 : 1.5,
                                    ),
                                  ),
                                  child: Text(
                                    d.name[0].toUpperCase() +
                                        d.name.substring(1),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: selected
                                          ? color
                                          : AppTheme.colorTextSecondary,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: AppTheme.spacing12),
                        // Add flashcard input
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    decoration: BoxDecoration(
                                      color: AppTheme.colorBackground,
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: _inputError != null
                                            ? AppTheme.colorCoral
                                            : _addedSuccess
                                                ? AppTheme.colorPrimary
                                                : AppTheme.colorBorder,
                                        width: 2,
                                      ),
                                    ),
                                    child: TextField(
                                      controller: _textController,
                                      maxLines: 2,
                                      maxLength: 300,
                                      onChanged: (_) {
                                        if (_inputError != null) _validateInput();
                                        if (_addedSuccess) setState(() => _addedSuccess = false);
                                      },
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.colorTextPrimary,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Type a new tongue twister...',
                                        hintStyle: const TextStyle(
                                          color: AppTheme.colorTextSecondary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        border: InputBorder.none,
                                        contentPadding: const EdgeInsets.all(AppTheme.spacing12),
                                        counterStyle: TextStyle(
                                          fontSize: 11,
                                          color: _textController.text.length > 270
                                              ? AppTheme.colorCoral
                                              : AppTheme.colorTextSecondary,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (_inputError != null) ...[  
                                    const SizedBox(height: AppTheme.spacing4),
                                    Row(
                                      children: [
                                        const Icon(Icons.error_outline_rounded,
                                            size: 13, color: AppTheme.colorCoral),
                                        const SizedBox(width: 4),
                                        Text(
                                          _inputError!,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: AppTheme.colorCoral,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                  if (_addedSuccess) ...[  
                                    const SizedBox(height: AppTheme.spacing4),
                                    Row(
                                      children: [
                                        const Icon(Icons.check_circle_rounded,
                                            size: 13, color: AppTheme.colorPrimary),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Flashcard added successfully!',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppTheme.colorPrimary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            const SizedBox(width: AppTheme.spacing8),
                            GestureDetector(
                              onTap: _saving ? null : _addFlashcard,
                              child: Container(
                                padding: const EdgeInsets.all(AppTheme.spacing12),
                                decoration: BoxDecoration(
                                  color: AppTheme.colorPrimary,
                                  borderRadius: BorderRadius.circular(14),
                                  border: const Border(
                                    bottom: BorderSide(
                                      color: AppTheme.colorPrimaryDark,
                                      width: 3,
                                    ),
                                  ),
                                ),
                                child: _saving
                                    ? const SizedBox(
                                        height: 22,
                                        width: 22,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Icon(Icons.add_rounded,
                                        color: Colors.white, size: 22),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Count badge
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacing16,
                      vertical: AppTheme.spacing12,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.spacing12,
                            vertical: AppTheme.spacing4,
                          ),
                          decoration: BoxDecoration(
                            color: diffColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: diffColor.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            '${_flashcards.length} card${_flashcards.length == 1 ? '' : 's'}',
                            style: TextStyle(
                              color: diffColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Flashcard list
                  Expanded(
                    child: _flashcards.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.style_outlined,
                                    size: 48,
                                    color: AppTheme.colorTextSecondary
                                        .withValues(alpha: 0.4)),
                                const SizedBox(height: AppTheme.spacing12),
                                Text(
                                  'No flashcards yet.\nAdd one above!',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: AppTheme.colorTextSecondary
                                            .withValues(alpha: 0.6),
                                      ),
                                ),
                              ],
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.fromLTRB(
                              AppTheme.spacing16,
                              0,
                              AppTheme.spacing16,
                              AppTheme.spacing16,
                            ),
                            itemCount: _flashcards.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: AppTheme.spacing8),
                            itemBuilder: (context, index) {
                              final card = _flashcards[index];
                              return Container(
                                padding: const EdgeInsets.only(
                                  left: AppTheme.spacing16,
                                  top: AppTheme.spacing12,
                                  bottom: AppTheme.spacing12,
                                  right: AppTheme.spacing4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.colorSurface,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: AppTheme.colorBorder,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.black.withValues(alpha: 0.03),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: diffColor.withValues(alpha: 0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${index + 1}',
                                          style: TextStyle(
                                            color: diffColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: AppTheme.spacing12),
                                    Expanded(
                                      child: Text(
                                        card['text'] as String,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.colorTextPrimary,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                          Icons.delete_outline_rounded),
                                      color: AppTheme.colorCoral
                                          .withValues(alpha: 0.7),
                                      onPressed: () =>
                                          _deleteFlashcard(card['id'] as String),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}

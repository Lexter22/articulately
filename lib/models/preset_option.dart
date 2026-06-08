class PresetOption {
  final String label;
  final String subtitle;
  final int? cardCount; // null means "all"

  const PresetOption({
    required this.label,
    required this.subtitle,
    this.cardCount,
  });
}

const defaultPresets = [
  PresetOption(label: 'Quick', subtitle: '5 cards', cardCount: 5),
  PresetOption(label: 'Standard', subtitle: '10 cards', cardCount: 10),
  PresetOption(label: 'All', subtitle: 'All cards', cardCount: null),
];

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/nav_preferences_provider.dart';
import '../../../shared/providers/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final navPrefs = ref.watch(navPreferencesProvider);
    final themeNotifier = ref.read(themeModeProvider.notifier);
    final navNotifier = ref.read(navPreferencesProvider.notifier);

    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Apparence')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Apparence', style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 16),
          _buildCard(
            context: context,
            title: 'Sélectionner le thème de l’application',
            description:
                'Choisis entre Système, Clair ou Sombre avec un look pillule.',
            child: SegmentedButton<ThemeMode>(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(value: ThemeMode.system, label: Text('Système')),
                ButtonSegment(value: ThemeMode.light, label: Text('Clair')),
                ButtonSegment(value: ThemeMode.dark, label: Text('Sombre')),
              ],
              selected: {themeMode},
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(72, 38)),
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return colorScheme.primaryContainer;
                  }
                  return colorScheme.surfaceVariant;
                }),
                foregroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return colorScheme.onPrimaryContainer;
                  }
                  return colorScheme.onSurfaceVariant;
                }),
                side: MaterialStateProperty.all(
                    BorderSide(color: colorScheme.outline)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                ),
                textStyle: MaterialStateProperty.all(
                    const TextStyle(fontWeight: FontWeight.w600)),
              ),
              onSelectionChanged: (selection) {
                if (selection.isNotEmpty) {
                  themeNotifier.setThemeMode(selection.first);
                }
              },
            ),
          ),
          const SizedBox(height: 16),
          _buildCard(
            context: context,
            title: 'Barre de navigation',
            description: 'Choisis le style et l’affichage des étiquettes.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: NavBarStyle.values.map((style) {
                    final selected = navPrefs.style == style;
                    return ChoiceChip(
                      label: Text(style == NavBarStyle.anchored
                          ? 'Ancrée'
                          : 'Flottante'),
                      selected: selected,
                      onSelected: (_) => navNotifier.setStyle(style),
                      selectedColor: colorScheme.primaryContainer,
                      backgroundColor: colorScheme.surfaceVariant,
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: selected
                            ? colorScheme.onPrimaryContainer
                            : colorScheme.onSurfaceVariant,
                      ),
                      side: BorderSide(color: colorScheme.outline),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: NavLabelMode.values.map((mode) {
                    final selected = navPrefs.labelMode == mode;
                    return ChoiceChip(
                      label: Text(mode.label),
                      selected: selected,
                      onSelected: (_) => navNotifier.setLabelMode(mode),
                      selectedColor: colorScheme.secondaryContainer,
                      backgroundColor: colorScheme.surfaceVariant,
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: selected
                            ? colorScheme.onSecondaryContainer
                            : colorScheme.onSurfaceVariant,
                      ),
                      side: BorderSide(color: colorScheme.outlineVariant),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 8),
                Text('Étiquettes: ${navPrefs.labelMode.label}',
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildCard(
            context: context,
            title: 'Dictionnaire',
            description: 'ODS 9 (Défaut)',
            child: null,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildCard({
    required BuildContext context,
    required String title,
    Widget? child,
    String? description,
  }) {
    final color = Theme.of(context).colorScheme.surfaceVariant;
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            if (description != null) ...[
              const SizedBox(height: 8),
              Text(description, style: Theme.of(context).textTheme.bodySmall),
            ],
            if (child != null) ...[
              const SizedBox(height: 12),
              child,
            ],
          ],
        ),
      ),
    );
  }
}

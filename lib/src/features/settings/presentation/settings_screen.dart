import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/providers/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Thème'),
            subtitle: Text(themeMode.name.toUpperCase()),
            trailing: const Icon(Icons.brightness_6),
            onTap: () {
              // Cycle next theme
              final nextIndex = (themeMode.index + 1) % ThemeMode.values.length;
              ref.read(themeModeProvider.notifier).setThemeMode(ThemeMode.values[nextIndex]);
            },
          ),
          const Divider(),
          const ListTile(
            title: Text('Dictionnaire'),
            subtitle: Text('ODS 9 (Défaut)'),
            enabled: false, // TODO
          ),
        ],
      ),
    );
  }
}

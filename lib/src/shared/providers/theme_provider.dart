import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Clé de persistence
const _themeKey = 'theme_mode';

// Provider pour SharedPreferences (devrait être override dans main.dart)
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

// Notifier pour gérer le ThemeMode
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  final SharedPreferences prefs;

  ThemeModeNotifier(this.prefs) : super(_initialMode(prefs));

  static ThemeMode _initialMode(SharedPreferences prefs) {
    final index = prefs.getInt(_themeKey);
    if (index != null && index >= 0 && index < ThemeMode.values.length) {
      return ThemeMode.values[index];
    }
    return ThemeMode.system;
  }

  void setThemeMode(ThemeMode mode) {
    state = mode;
    prefs.setInt(_themeKey, mode.index);
  }
}

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return ThemeModeNotifier(prefs);
});

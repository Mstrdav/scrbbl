import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_provider.dart' show sharedPreferencesProvider;

const _navStyleKey = 'nav_bar_style';
const _navLabelModeKey = 'nav_bar_label_mode';

enum NavBarStyle { anchored, floating }

enum NavLabelMode { always, activeOnly, iconsOnly }

extension NavLabelModeX on NavLabelMode {
  NavigationDestinationLabelBehavior get behavior {
    switch (this) {
      case NavLabelMode.activeOnly:
        return NavigationDestinationLabelBehavior.onlyShowSelected;
      case NavLabelMode.iconsOnly:
        return NavigationDestinationLabelBehavior.alwaysHide;
      case NavLabelMode.always:
      default:
        return NavigationDestinationLabelBehavior.alwaysShow;
    }
  }

  String get label {
    switch (this) {
      case NavLabelMode.activeOnly:
        return 'Actif uniquement';
      case NavLabelMode.iconsOnly:
        return 'Icônes seules';
      case NavLabelMode.always:
      default:
        return 'Toujours';
    }
  }
}

class NavPreferencesState {
  final NavBarStyle style;
  final NavLabelMode labelMode;

  const NavPreferencesState({required this.style, required this.labelMode});

  NavPreferencesState copyWith({NavBarStyle? style, NavLabelMode? labelMode}) {
    return NavPreferencesState(
      style: style ?? this.style,
      labelMode: labelMode ?? this.labelMode,
    );
  }
}

class NavPreferencesNotifier extends StateNotifier<NavPreferencesState> {
  final SharedPreferences _prefs;

  NavPreferencesNotifier(this._prefs) : super(_initialState(_prefs));

  static NavPreferencesState _initialState(SharedPreferences prefs) {
    final styleIndex = prefs.getInt(_navStyleKey);
    final style = (styleIndex != null &&
            styleIndex >= 0 &&
            styleIndex < NavBarStyle.values.length)
        ? NavBarStyle.values[styleIndex]
        : NavBarStyle.anchored;
    final labelModeIndex = prefs.getInt(_navLabelModeKey);
    final labelMode = (labelModeIndex != null &&
            labelModeIndex >= 0 &&
            labelModeIndex < NavLabelMode.values.length)
        ? NavLabelMode.values[labelModeIndex]
        : NavLabelMode.always;
    return NavPreferencesState(style: style, labelMode: labelMode);
  }

  void setStyle(NavBarStyle style) {
    state = state.copyWith(style: style);
    _prefs.setInt(_navStyleKey, style.index);
  }

  void setLabelMode(NavLabelMode mode) {
    state = state.copyWith(labelMode: mode);
    _prefs.setInt(_navLabelModeKey, mode.index);
  }
}

final navPreferencesProvider =
    StateNotifierProvider<NavPreferencesNotifier, NavPreferencesState>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return NavPreferencesNotifier(prefs);
});

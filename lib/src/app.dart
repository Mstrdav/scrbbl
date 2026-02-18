import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'routing/router.dart';
import 'shared/providers/theme_provider.dart';

// Couleur de base (Cuivre/Orange) si Dynamic Color n'est pas dispo
const _defaultSeedColor = Color(0xFFD2691E);

class ScrbblApp extends ConsumerWidget {
  const ScrbblApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        // Construction des thèmes
        final lightTheme = _buildTheme(
          colorScheme: lightDynamic ??
              ColorScheme.fromSeed(
                seedColor: _defaultSeedColor,
                brightness: Brightness.light,
              ),
        );

        final darkTheme = _buildTheme(
          colorScheme: darkDynamic ??
              ColorScheme.fromSeed(
                seedColor: _defaultSeedColor,
                brightness: Brightness.dark,
              ),
        );

        return MaterialApp.router(
          title: 'Scrbbl',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          routerConfig: router,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }

  ThemeData _buildTheme({required ColorScheme colorScheme}) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
      ),
    );
  }
}

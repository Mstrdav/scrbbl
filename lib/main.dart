import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/app.dart';
import 'src/data/database/app_database.dart';
import 'src/shared/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init SharedPrefs
  final prefs = await SharedPreferences.getInstance();
  
  // Init Database (Lazy, mais on peut forcer l'ouverture ici si besoin)
  // On pourrait vérifier si le dico est vide et le remplir ici,
  // ou laisser un provider s'en charger.
  // Pour la démo, on laisse le provider faire le job à la demande ou au premier appel.

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const ScrbblApp(),
    ),
  );
}

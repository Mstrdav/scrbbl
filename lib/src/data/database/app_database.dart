import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Dictionary, WordProgress])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        // Cas normal (pas de copie d'asset ?) 
        // Si on copie l'asset, onCreate n'est PAS appelé car le fichier existe déjà.
        // C'est onUpgrade qui sera appelé (version 0 -> 1).
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 1) {
          // Si on vient de l'asset (version 0), on doit créer la table de progression
          // car l'asset ne contient que le dictionnaire.
          await m.createTable(wordProgress);
        }
      },
    );
  }
  Future<DictionaryEntry?> findWord(String query) {
    return (select(dictionary)..where((t) => t.word.equals(query.toUpperCase()))).getSingleOrNull();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.sqlite'));

    if (!await file.exists()) {
      // Premier lancement : Copie de l'asset dictionnaire
      try {
        final blob = await rootBundle.load('assets/db/dictionary.sqlite');
        final buffer = blob.buffer.asUint8List(blob.offsetInBytes, blob.lengthInBytes);
        await file.writeAsBytes(buffer, flush: true);
        print('Database copied from assets.');
      } catch (e) {
        print('Error copying database: $e');
        // Fallback: Créer vide (Drift le fera)
      }
    }

    return NativeDatabase.createInBackground(file);
  });
}

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

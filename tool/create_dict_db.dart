import 'dart:io';
import 'package:sqlite3/sqlite3.dart';

void main() {
  final dbPath = 'assets/db/dictionary.sqlite';
  // Clean old file
  if (File(dbPath).existsSync()) {
    File(dbPath).deleteSync();
  }
  
  // Ensure dir exists
  Directory('assets/db').createSync(recursive: true);

  print('Opening database...');
  final db = sqlite3.open(dbPath);
  
  // Create table
  db.execute('''
    CREATE TABLE dictionary (
      word TEXT PRIMARY KEY,
      definition TEXT
    );
  ''');

  // 1. Load Definitions (Map)
  print('Loading definitions...');
  final defsFile = File('assets/ODS9_definitions.txt');
  final defsMap = <String, String>{};
  
  if (defsFile.existsSync()) {
    final lines = defsFile.readAsLinesSync();
    for (final line in lines) {
      if (line.trim().isEmpty) continue;
      
      // Format: "MOT  Def..." or "MOT ,VAR  Def..."
      // On cherche le premier espace double ou espace simple après le mot ?
      // Le fichier a l'air d'utiliser des espaces.
      // Ex: "AA  Géol. n. Coulée..."
      
      final firstSpace = line.indexOf(' ');
      if (firstSpace == -1) continue;
      
      var wordPart = line.substring(0, firstSpace).trim();
      final defPart = line.substring(firstSpace).trim();
      
      // Nettoyage wordPart (ex: "AALENIEN ,ENNE")
      // On garde juste "AALENIEN" pour la clé principale
      if (wordPart.contains(',')) {
        wordPart = wordPart.split(',')[0].trim();
      }
      
      defsMap[wordPart] = defPart;
    }
    print('Loaded ${defsMap.length} definitions.');
  } else {
    print('Warning: Definitions file not found.');
  }

  // 2. Load Words and Insert
  print('Loading words and inserting...');
  final wordsFile = File('assets/ODS9.txt');
  if (!wordsFile.existsSync()) {
    print('Error: ODS9.txt not found.');
    return;
  }

  final words = wordsFile.readAsLinesSync();
  final stmt = db.prepare('INSERT OR IGNORE INTO dictionary (word, definition) VALUES (?, ?)');
  
  int count = 0;
  db.execute('BEGIN TRANSACTION');
  
  for (final line in words) {
    final word = line.trim().toUpperCase();
    if (word.isEmpty) continue;
    
    // Look for definition
    // Si c'est une forme fléchie, on n'a pas la def directe.
    // On pourrait essayer de trouver si le mot "commence par" une racine connue ?
    // Risqué (ABAISSAIT vs ABAISSER).
    // Pour l'instant, on met la def exacte si trouvée.
    final def = defsMap[word];
    
    stmt.execute([word, def]);
    count++;
    
    if (count % 10000 == 0) print('$count words processed...');
  }
  
  db.execute('COMMIT');
  stmt.dispose();
  db.dispose();
  
  print('Done! Created dictionary.sqlite with $count entries.');
}

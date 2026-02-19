import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/database/app_database.dart';

part 'search_controller.g.dart';

class WordResult {
  final String word;
  final String? definition;
  
  WordResult({required this.word, this.definition});
}

@riverpod
class SearchWord extends _$SearchWord {
  @override
  Future<WordResult?> build(String query) async {
    if (query.isEmpty) return null;
    final db = ref.watch(appDatabaseProvider);
    final entry = await db.findWord(query);
    
    if (entry != null) {
      return WordResult(word: entry.word, definition: entry.definition);
    }
    return null;
  }
}

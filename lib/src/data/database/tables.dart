import 'package:drift/drift.dart';

@DataClassName('DictionaryEntry')
class Dictionary extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get word => text().unique()();
  TextColumn get definition => text().nullable()();
  // Ajoutez d'autres champs si ODS9 en a (genre, pluriel, etc.)
}

@DataClassName('WordProgressEntry')
class WordProgress extends Table {
  TextColumn get word => text()(); // Clé primaire manuelle
  DateTimeColumn get nextReview => dateTime()();
  IntColumn get interval => integer().withDefault(const Constant(1))(); // Jours
  RealColumn get easeFactor => real().withDefault(const Constant(2.5))(); // Multiplicateur

  @override
  Set<Column> get primaryKey => {word};
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DictionaryTable extends Dictionary
    with TableInfo<$DictionaryTable, DictionaryEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DictionaryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<String> word = GeneratedColumn<String>(
      'word', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _definitionMeta =
      const VerificationMeta('definition');
  @override
  late final GeneratedColumn<String> definition = GeneratedColumn<String>(
      'definition', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, word, definition];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dictionary';
  @override
  VerificationContext validateIntegrity(Insertable<DictionaryEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('word')) {
      context.handle(
          _wordMeta, word.isAcceptableOrUnknown(data['word']!, _wordMeta));
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('definition')) {
      context.handle(
          _definitionMeta,
          definition.isAcceptableOrUnknown(
              data['definition']!, _definitionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DictionaryEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DictionaryEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      word: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}word'])!,
      definition: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}definition']),
    );
  }

  @override
  $DictionaryTable createAlias(String alias) {
    return $DictionaryTable(attachedDatabase, alias);
  }
}

class DictionaryEntry extends DataClass implements Insertable<DictionaryEntry> {
  final int id;
  final String word;
  final String? definition;
  const DictionaryEntry(
      {required this.id, required this.word, this.definition});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['word'] = Variable<String>(word);
    if (!nullToAbsent || definition != null) {
      map['definition'] = Variable<String>(definition);
    }
    return map;
  }

  DictionaryCompanion toCompanion(bool nullToAbsent) {
    return DictionaryCompanion(
      id: Value(id),
      word: Value(word),
      definition: definition == null && nullToAbsent
          ? const Value.absent()
          : Value(definition),
    );
  }

  factory DictionaryEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DictionaryEntry(
      id: serializer.fromJson<int>(json['id']),
      word: serializer.fromJson<String>(json['word']),
      definition: serializer.fromJson<String?>(json['definition']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'word': serializer.toJson<String>(word),
      'definition': serializer.toJson<String?>(definition),
    };
  }

  DictionaryEntry copyWith(
          {int? id,
          String? word,
          Value<String?> definition = const Value.absent()}) =>
      DictionaryEntry(
        id: id ?? this.id,
        word: word ?? this.word,
        definition: definition.present ? definition.value : this.definition,
      );
  DictionaryEntry copyWithCompanion(DictionaryCompanion data) {
    return DictionaryEntry(
      id: data.id.present ? data.id.value : this.id,
      word: data.word.present ? data.word.value : this.word,
      definition:
          data.definition.present ? data.definition.value : this.definition,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DictionaryEntry(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('definition: $definition')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, word, definition);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DictionaryEntry &&
          other.id == this.id &&
          other.word == this.word &&
          other.definition == this.definition);
}

class DictionaryCompanion extends UpdateCompanion<DictionaryEntry> {
  final Value<int> id;
  final Value<String> word;
  final Value<String?> definition;
  const DictionaryCompanion({
    this.id = const Value.absent(),
    this.word = const Value.absent(),
    this.definition = const Value.absent(),
  });
  DictionaryCompanion.insert({
    this.id = const Value.absent(),
    required String word,
    this.definition = const Value.absent(),
  }) : word = Value(word);
  static Insertable<DictionaryEntry> custom({
    Expression<int>? id,
    Expression<String>? word,
    Expression<String>? definition,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (word != null) 'word': word,
      if (definition != null) 'definition': definition,
    });
  }

  DictionaryCompanion copyWith(
      {Value<int>? id, Value<String>? word, Value<String?>? definition}) {
    return DictionaryCompanion(
      id: id ?? this.id,
      word: word ?? this.word,
      definition: definition ?? this.definition,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    if (definition.present) {
      map['definition'] = Variable<String>(definition.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DictionaryCompanion(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('definition: $definition')
          ..write(')'))
        .toString();
  }
}

class $WordProgressTable extends WordProgress
    with TableInfo<$WordProgressTable, WordProgressEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<String> word = GeneratedColumn<String>(
      'word', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nextReviewMeta =
      const VerificationMeta('nextReview');
  @override
  late final GeneratedColumn<DateTime> nextReview = GeneratedColumn<DateTime>(
      'next_review', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _intervalMeta =
      const VerificationMeta('interval');
  @override
  late final GeneratedColumn<int> interval = GeneratedColumn<int>(
      'interval', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _easeFactorMeta =
      const VerificationMeta('easeFactor');
  @override
  late final GeneratedColumn<double> easeFactor = GeneratedColumn<double>(
      'ease_factor', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(2.5));
  @override
  List<GeneratedColumn> get $columns =>
      [word, nextReview, interval, easeFactor];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_progress';
  @override
  VerificationContext validateIntegrity(Insertable<WordProgressEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('word')) {
      context.handle(
          _wordMeta, word.isAcceptableOrUnknown(data['word']!, _wordMeta));
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('next_review')) {
      context.handle(
          _nextReviewMeta,
          nextReview.isAcceptableOrUnknown(
              data['next_review']!, _nextReviewMeta));
    } else if (isInserting) {
      context.missing(_nextReviewMeta);
    }
    if (data.containsKey('interval')) {
      context.handle(_intervalMeta,
          interval.isAcceptableOrUnknown(data['interval']!, _intervalMeta));
    }
    if (data.containsKey('ease_factor')) {
      context.handle(
          _easeFactorMeta,
          easeFactor.isAcceptableOrUnknown(
              data['ease_factor']!, _easeFactorMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {word};
  @override
  WordProgressEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordProgressEntry(
      word: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}word'])!,
      nextReview: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}next_review'])!,
      interval: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}interval'])!,
      easeFactor: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}ease_factor'])!,
    );
  }

  @override
  $WordProgressTable createAlias(String alias) {
    return $WordProgressTable(attachedDatabase, alias);
  }
}

class WordProgressEntry extends DataClass
    implements Insertable<WordProgressEntry> {
  final String word;
  final DateTime nextReview;
  final int interval;
  final double easeFactor;
  const WordProgressEntry(
      {required this.word,
      required this.nextReview,
      required this.interval,
      required this.easeFactor});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['word'] = Variable<String>(word);
    map['next_review'] = Variable<DateTime>(nextReview);
    map['interval'] = Variable<int>(interval);
    map['ease_factor'] = Variable<double>(easeFactor);
    return map;
  }

  WordProgressCompanion toCompanion(bool nullToAbsent) {
    return WordProgressCompanion(
      word: Value(word),
      nextReview: Value(nextReview),
      interval: Value(interval),
      easeFactor: Value(easeFactor),
    );
  }

  factory WordProgressEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordProgressEntry(
      word: serializer.fromJson<String>(json['word']),
      nextReview: serializer.fromJson<DateTime>(json['nextReview']),
      interval: serializer.fromJson<int>(json['interval']),
      easeFactor: serializer.fromJson<double>(json['easeFactor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'word': serializer.toJson<String>(word),
      'nextReview': serializer.toJson<DateTime>(nextReview),
      'interval': serializer.toJson<int>(interval),
      'easeFactor': serializer.toJson<double>(easeFactor),
    };
  }

  WordProgressEntry copyWith(
          {String? word,
          DateTime? nextReview,
          int? interval,
          double? easeFactor}) =>
      WordProgressEntry(
        word: word ?? this.word,
        nextReview: nextReview ?? this.nextReview,
        interval: interval ?? this.interval,
        easeFactor: easeFactor ?? this.easeFactor,
      );
  WordProgressEntry copyWithCompanion(WordProgressCompanion data) {
    return WordProgressEntry(
      word: data.word.present ? data.word.value : this.word,
      nextReview:
          data.nextReview.present ? data.nextReview.value : this.nextReview,
      interval: data.interval.present ? data.interval.value : this.interval,
      easeFactor:
          data.easeFactor.present ? data.easeFactor.value : this.easeFactor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordProgressEntry(')
          ..write('word: $word, ')
          ..write('nextReview: $nextReview, ')
          ..write('interval: $interval, ')
          ..write('easeFactor: $easeFactor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(word, nextReview, interval, easeFactor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordProgressEntry &&
          other.word == this.word &&
          other.nextReview == this.nextReview &&
          other.interval == this.interval &&
          other.easeFactor == this.easeFactor);
}

class WordProgressCompanion extends UpdateCompanion<WordProgressEntry> {
  final Value<String> word;
  final Value<DateTime> nextReview;
  final Value<int> interval;
  final Value<double> easeFactor;
  final Value<int> rowid;
  const WordProgressCompanion({
    this.word = const Value.absent(),
    this.nextReview = const Value.absent(),
    this.interval = const Value.absent(),
    this.easeFactor = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WordProgressCompanion.insert({
    required String word,
    required DateTime nextReview,
    this.interval = const Value.absent(),
    this.easeFactor = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : word = Value(word),
        nextReview = Value(nextReview);
  static Insertable<WordProgressEntry> custom({
    Expression<String>? word,
    Expression<DateTime>? nextReview,
    Expression<int>? interval,
    Expression<double>? easeFactor,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (word != null) 'word': word,
      if (nextReview != null) 'next_review': nextReview,
      if (interval != null) 'interval': interval,
      if (easeFactor != null) 'ease_factor': easeFactor,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WordProgressCompanion copyWith(
      {Value<String>? word,
      Value<DateTime>? nextReview,
      Value<int>? interval,
      Value<double>? easeFactor,
      Value<int>? rowid}) {
    return WordProgressCompanion(
      word: word ?? this.word,
      nextReview: nextReview ?? this.nextReview,
      interval: interval ?? this.interval,
      easeFactor: easeFactor ?? this.easeFactor,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    if (nextReview.present) {
      map['next_review'] = Variable<DateTime>(nextReview.value);
    }
    if (interval.present) {
      map['interval'] = Variable<int>(interval.value);
    }
    if (easeFactor.present) {
      map['ease_factor'] = Variable<double>(easeFactor.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordProgressCompanion(')
          ..write('word: $word, ')
          ..write('nextReview: $nextReview, ')
          ..write('interval: $interval, ')
          ..write('easeFactor: $easeFactor, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DictionaryTable dictionary = $DictionaryTable(this);
  late final $WordProgressTable wordProgress = $WordProgressTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [dictionary, wordProgress];
}

typedef $$DictionaryTableCreateCompanionBuilder = DictionaryCompanion Function({
  Value<int> id,
  required String word,
  Value<String?> definition,
});
typedef $$DictionaryTableUpdateCompanionBuilder = DictionaryCompanion Function({
  Value<int> id,
  Value<String> word,
  Value<String?> definition,
});

class $$DictionaryTableFilterComposer
    extends Composer<_$AppDatabase, $DictionaryTable> {
  $$DictionaryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get word => $composableBuilder(
      column: $table.word, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get definition => $composableBuilder(
      column: $table.definition, builder: (column) => ColumnFilters(column));
}

class $$DictionaryTableOrderingComposer
    extends Composer<_$AppDatabase, $DictionaryTable> {
  $$DictionaryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get word => $composableBuilder(
      column: $table.word, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get definition => $composableBuilder(
      column: $table.definition, builder: (column) => ColumnOrderings(column));
}

class $$DictionaryTableAnnotationComposer
    extends Composer<_$AppDatabase, $DictionaryTable> {
  $$DictionaryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get word =>
      $composableBuilder(column: $table.word, builder: (column) => column);

  GeneratedColumn<String> get definition => $composableBuilder(
      column: $table.definition, builder: (column) => column);
}

class $$DictionaryTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DictionaryTable,
    DictionaryEntry,
    $$DictionaryTableFilterComposer,
    $$DictionaryTableOrderingComposer,
    $$DictionaryTableAnnotationComposer,
    $$DictionaryTableCreateCompanionBuilder,
    $$DictionaryTableUpdateCompanionBuilder,
    (
      DictionaryEntry,
      BaseReferences<_$AppDatabase, $DictionaryTable, DictionaryEntry>
    ),
    DictionaryEntry,
    PrefetchHooks Function()> {
  $$DictionaryTableTableManager(_$AppDatabase db, $DictionaryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DictionaryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DictionaryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DictionaryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> word = const Value.absent(),
            Value<String?> definition = const Value.absent(),
          }) =>
              DictionaryCompanion(
            id: id,
            word: word,
            definition: definition,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String word,
            Value<String?> definition = const Value.absent(),
          }) =>
              DictionaryCompanion.insert(
            id: id,
            word: word,
            definition: definition,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DictionaryTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DictionaryTable,
    DictionaryEntry,
    $$DictionaryTableFilterComposer,
    $$DictionaryTableOrderingComposer,
    $$DictionaryTableAnnotationComposer,
    $$DictionaryTableCreateCompanionBuilder,
    $$DictionaryTableUpdateCompanionBuilder,
    (
      DictionaryEntry,
      BaseReferences<_$AppDatabase, $DictionaryTable, DictionaryEntry>
    ),
    DictionaryEntry,
    PrefetchHooks Function()>;
typedef $$WordProgressTableCreateCompanionBuilder = WordProgressCompanion
    Function({
  required String word,
  required DateTime nextReview,
  Value<int> interval,
  Value<double> easeFactor,
  Value<int> rowid,
});
typedef $$WordProgressTableUpdateCompanionBuilder = WordProgressCompanion
    Function({
  Value<String> word,
  Value<DateTime> nextReview,
  Value<int> interval,
  Value<double> easeFactor,
  Value<int> rowid,
});

class $$WordProgressTableFilterComposer
    extends Composer<_$AppDatabase, $WordProgressTable> {
  $$WordProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get word => $composableBuilder(
      column: $table.word, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get nextReview => $composableBuilder(
      column: $table.nextReview, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get interval => $composableBuilder(
      column: $table.interval, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get easeFactor => $composableBuilder(
      column: $table.easeFactor, builder: (column) => ColumnFilters(column));
}

class $$WordProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $WordProgressTable> {
  $$WordProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get word => $composableBuilder(
      column: $table.word, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get nextReview => $composableBuilder(
      column: $table.nextReview, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get interval => $composableBuilder(
      column: $table.interval, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get easeFactor => $composableBuilder(
      column: $table.easeFactor, builder: (column) => ColumnOrderings(column));
}

class $$WordProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordProgressTable> {
  $$WordProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get word =>
      $composableBuilder(column: $table.word, builder: (column) => column);

  GeneratedColumn<DateTime> get nextReview => $composableBuilder(
      column: $table.nextReview, builder: (column) => column);

  GeneratedColumn<int> get interval =>
      $composableBuilder(column: $table.interval, builder: (column) => column);

  GeneratedColumn<double> get easeFactor => $composableBuilder(
      column: $table.easeFactor, builder: (column) => column);
}

class $$WordProgressTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WordProgressTable,
    WordProgressEntry,
    $$WordProgressTableFilterComposer,
    $$WordProgressTableOrderingComposer,
    $$WordProgressTableAnnotationComposer,
    $$WordProgressTableCreateCompanionBuilder,
    $$WordProgressTableUpdateCompanionBuilder,
    (
      WordProgressEntry,
      BaseReferences<_$AppDatabase, $WordProgressTable, WordProgressEntry>
    ),
    WordProgressEntry,
    PrefetchHooks Function()> {
  $$WordProgressTableTableManager(_$AppDatabase db, $WordProgressTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> word = const Value.absent(),
            Value<DateTime> nextReview = const Value.absent(),
            Value<int> interval = const Value.absent(),
            Value<double> easeFactor = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WordProgressCompanion(
            word: word,
            nextReview: nextReview,
            interval: interval,
            easeFactor: easeFactor,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String word,
            required DateTime nextReview,
            Value<int> interval = const Value.absent(),
            Value<double> easeFactor = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WordProgressCompanion.insert(
            word: word,
            nextReview: nextReview,
            interval: interval,
            easeFactor: easeFactor,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WordProgressTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WordProgressTable,
    WordProgressEntry,
    $$WordProgressTableFilterComposer,
    $$WordProgressTableOrderingComposer,
    $$WordProgressTableAnnotationComposer,
    $$WordProgressTableCreateCompanionBuilder,
    $$WordProgressTableUpdateCompanionBuilder,
    (
      WordProgressEntry,
      BaseReferences<_$AppDatabase, $WordProgressTable, WordProgressEntry>
    ),
    WordProgressEntry,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DictionaryTableTableManager get dictionary =>
      $$DictionaryTableTableManager(_db, _db.dictionary);
  $$WordProgressTableTableManager get wordProgress =>
      $$WordProgressTableTableManager(_db, _db.wordProgress);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  LegendDao _legendDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Legend` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `nacionality` TEXT, `championshipsWon` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  LegendDao get legendDao {
    return _legendDaoInstance ??= _$LegendDao(database, changeListener);
  }
}

class _$LegendDao extends LegendDao {
  _$LegendDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _legendInsertionAdapter = InsertionAdapter(
            database,
            'Legend',
            (Legend item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'nacionality': item.nacionality,
                  'championshipsWon': item.championshipsWon
                }),
        _legendDeletionAdapter = DeletionAdapter(
            database,
            'Legend',
            ['id'],
            (Legend item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'nacionality': item.nacionality,
                  'championshipsWon': item.championshipsWon
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _legendMapper = (Map<String, dynamic> row) => Legend(
      id: row['id'] as int,
      name: row['name'] as String,
      nacionality: row['nacionality'] as String,
      championshipsWon: row['championshipsWon'] as String);

  final InsertionAdapter<Legend> _legendInsertionAdapter;

  final DeletionAdapter<Legend> _legendDeletionAdapter;

  @override
  Future<List<Legend>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM Legend',
        mapper: _legendMapper);
  }

  @override
  Future<int> insertLegend(Legend legend) {
    return _legendInsertionAdapter.insertAndReturnId(
        legend, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteLegend(Legend legend) {
    return _legendDeletionAdapter.deleteAndReturnChangedRows(legend);
  }
}

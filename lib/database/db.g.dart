// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

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

  ContactDao _contactInstance;

  FavouriteListDao _flInstance;

  PastContactsSendMessageDao _pcsmInstance;

  BlackListDao _blacklistdaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `LocalContact` (`id` TEXT, `foreignlistid` TEXT, `givename` TEXT, `phones` TEXT, `temp` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `FavouriteList` (`id` TEXT, `name` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PastContactsSendMessage` (`id` TEXT, `contactcount` INTEGER, `msg` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `BlackListedNumber` (`id` TEXT, `number` TEXT, `date` TEXT, `time` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ContactDao get contact {
    return _contactInstance ??= _$ContactDao(database, changeListener);
  }

  @override
  FavouriteListDao get fl {
    return _flInstance ??= _$FavouriteListDao(database, changeListener);
  }

  @override
  PastContactsSendMessageDao get pcsm {
    return _pcsmInstance ??=
        _$PastContactsSendMessageDao(database, changeListener);
  }

  @override
  BlackListDao get blacklistdao {
    return _blacklistdaoInstance ??= _$BlackListDao(database, changeListener);
  }
}

class _$ContactDao extends ContactDao {
  _$ContactDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _localContactInsertionAdapter = InsertionAdapter(
            database,
            'LocalContact',
            (LocalContact item) => <String, dynamic>{
                  'id': item.id,
                  'foreignlistid': item.foreignlistid,
                  'givename': item.givename,
                  'phones': item.phones,
                  'temp': item.temp == null ? null : (item.temp ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _localContactMapper = (Map<String, dynamic> row) => LocalContact(
      row['id'] as String,
      row['foreignlistid'] as String,
      row['givename'] as String,
      row['phones'] as String,
      row['temp'] == null ? null : (row['temp'] as int) != 0);

  final InsertionAdapter<LocalContact> _localContactInsertionAdapter;

  @override
  Future<List<LocalContact>> getcontact(bool temp, String id) async {
    return _queryAdapter.queryList(
        'Select * from LocalContact where temp= ? and foreignlistid= ?',
        arguments: <dynamic>[temp == null ? null : (temp ? 1 : 0), id],
        mapper: _localContactMapper);
  }

  @override
  Future<void> insertcontacts(LocalContact contact) async {
    await _localContactInsertionAdapter.insert(
        contact, OnConflictStrategy.abort);
  }
}

class _$FavouriteListDao extends FavouriteListDao {
  _$FavouriteListDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _favouriteListInsertionAdapter = InsertionAdapter(
            database,
            'FavouriteList',
            (FavouriteList item) =>
                <String, dynamic>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _favouriteListMapper = (Map<String, dynamic> row) =>
      FavouriteList(row['id'] as String, row['name'] as String);

  final InsertionAdapter<FavouriteList> _favouriteListInsertionAdapter;

  @override
  Future<List<FavouriteList>> getlist() async {
    return _queryAdapter.queryList('Select * from favouritelist',
        mapper: _favouriteListMapper);
  }

  @override
  Future<void> insertlist(FavouriteList list) async {
    await _favouriteListInsertionAdapter.insert(list, OnConflictStrategy.abort);
  }
}

class _$PastContactsSendMessageDao extends PastContactsSendMessageDao {
  _$PastContactsSendMessageDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _pastContactsSendMessageInsertionAdapter = InsertionAdapter(
            database,
            'PastContactsSendMessage',
            (PastContactsSendMessage item) => <String, dynamic>{
                  'id': item.id,
                  'contactcount': item.contactcount,
                  'msg': item.msg
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _pastContactsSendMessageMapper = (Map<String, dynamic> row) =>
      PastContactsSendMessage(row['id'] as String, row['contactcount'] as int,
          row['msg'] as String);

  final InsertionAdapter<PastContactsSendMessage>
      _pastContactsSendMessageInsertionAdapter;

  @override
  Future<List<PastContactsSendMessage>> getpastSendMessage() async {
    return _queryAdapter.queryList('Select * from PastContactsSendMessage',
        mapper: _pastContactsSendMessageMapper);
  }

  @override
  Future<void> inserttemplist(
      PastContactsSendMessage pastContactsSendMessage) async {
    await _pastContactsSendMessageInsertionAdapter.insert(
        pastContactsSendMessage, OnConflictStrategy.abort);
  }
}

class _$BlackListDao extends BlackListDao {
  _$BlackListDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _blackListedNumberInsertionAdapter = InsertionAdapter(
            database,
            'BlackListedNumber',
            (BlackListedNumber item) => <String, dynamic>{
                  'id': item.id,
                  'number': item.number,
                  'date': item.date,
                  'time': item.time
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _blackListedNumberMapper = (Map<String, dynamic> row) =>
      BlackListedNumber(row['id'] as String, row['number'] as String,
          row['date'] as String, row['time'] as String);

  final InsertionAdapter<BlackListedNumber> _blackListedNumberInsertionAdapter;

  @override
  Future<List<BlackListedNumber>> getallNumbers() async {
    return _queryAdapter.queryList('Select * from BlackListedNumber',
        mapper: _blackListedNumberMapper);
  }

  @override
  Future<void> deleteNumber(String id) async {
    await _queryAdapter.queryNoReturn(
        'Delete from BlackListedNumber where id= ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> save(BlackListedNumber blackListedNumber) async {
    await _blackListedNumberInsertionAdapter.insert(
        blackListedNumber, OnConflictStrategy.abort);
  }
}

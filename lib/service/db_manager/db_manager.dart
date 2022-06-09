import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:zens_test_flutter/service/db_manager/joke_data_manager.dart';

abstract class DBManager {
  factory DBManager() => _DBManagerImpl();

  /// Check if db is existing
  Future<bool> isDbExist();

  /// Get db file path
  Future<String> getDbFileDir();

  Future<bool> initialize();

  Future<Database> get database;

  String get dbName;

  JokeDataManager get jokeDataManager;
  // UserDataMemoWordDao get userDataMemoWordDao;
}

class _DBManagerImpl implements DBManager {
  Database? _database;
  late JokeDataManager jokeDataManager;
  @override
  Future<Database> get database async {
    if (_database == null) {
      await initialize();
    }
    return _database!;
  }

  @override
  String get dbName => "listcontact.db";

  @override
  Future<String> getDbFileDir() async {
    var databasesPath = await getDatabasesPath();
    var resultPath = path.join(databasesPath, dbName);
    return resultPath;
  }

  @override
  Future<bool> initialize() async {
    if (_database != null) {
      return true;
    }

    final dbPath = await getDbFilePath();
    final database = await openDatabase(dbPath, version: 1);

    _database = database;
    jokeDataManager = JokeDataManager(database);
    await database.execute("CREATE TABLE IF NOT EXISTS joke("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "content TEXT,"
        "is_fun INTEGER"
        ")");

    return true;
  }

  Future<String> getDbFilePath() async {
    var databasesPath = await getDatabasesPath();
    var resultPath = path.join(databasesPath, dbName);

    var exists = await databaseExists(resultPath);

    if (!exists) {
      print("Creating new copy from asset");

      try {
        await Directory(path.dirname(resultPath)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(path.join("assets/db/", dbName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(resultPath).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }

    print(resultPath);

    return resultPath;
  }

  @override
  Future<bool> isDbExist() async {
    final dbPath = await getDbFilePath();
    return File(dbPath).exists();
  }
}

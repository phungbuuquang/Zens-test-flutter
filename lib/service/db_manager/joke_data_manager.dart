import 'package:sqflite/sqflite.dart';
import 'package:zens_test_flutter/data/local/joke/joke_model.dart';

const _tableName = "joke";

abstract class JokeDataManager {
  factory JokeDataManager(Database database) => _JokeDataManagerImpl(database);

  Future<int> insert(JokeModel contact);

  Future<bool> update(
    int isFun,
    int id,
  );

  Future<void> selectAll();
}

class _JokeDataManagerImpl implements JokeDataManager {
  _JokeDataManagerImpl(this.database);
  final Database database;

  @override
  Future<int> insert(JokeModel contact) async {
    final value = contact.toJson();
    int count = await database.insert(
      _tableName,
      value,
    );
    selectAll();
    return count;
  }

  @override
  Future<bool> update(int isFun, int id) {
    throw UnimplementedError();
  }

  @override
  Future<void> selectAll() async {
    final data = await database.rawQuery("select * from joke");
    print(data);
  }
}

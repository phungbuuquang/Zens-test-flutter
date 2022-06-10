import 'package:sqflite/sqflite.dart';
import 'package:zens_test_flutter/data/local/joke/joke_model.dart';

const _tableName = "joke";

abstract class JokeDataManager {
  factory JokeDataManager(Database database) => _JokeDataManagerImpl(database);

  Future<int> insert(JokeModel joke);

  Future<int> update(
    int isFun,
    int id,
  );

  Future<List<JokeModel>> selectAll();
  Future<int> clearAll();
  Future<void> reset();
}

class _JokeDataManagerImpl implements JokeDataManager {
  _JokeDataManagerImpl(this.database);
  final Database database;

  @override
  Future<int> insert(JokeModel joke) async {
    final value = joke.toJson();
    int count = await database.insert(
      _tableName,
      value,
    );

    return count;
  }

  @override
  Future<int> update(int isFun, int id) async {
    int count = await database
        .rawUpdate('UPDATE $_tableName SET is_fun = ? WHERE id = ?', [
      isFun,
      id.toString(),
    ]);
    print('updated: $count');
    return count;
  }

  @override
  Future<List<JokeModel>> selectAll() async {
    final data =
        await database.rawQuery("select * from joke where is_fun is null");
    print(data);
    List<JokeModel> datas = [];
    for (var item in data) {
      datas.add(JokeModel.fromJson(item));
    }
    return datas;
  }

  @override
  Future<int> clearAll() async {
    int data = await database.delete(_tableName);
    return data;
  }

  @override
  Future<void> reset() async {
    int count =
        await database.rawUpdate('UPDATE $_tableName SET is_fun = NULL');
    print('updated: $count');
  }
}

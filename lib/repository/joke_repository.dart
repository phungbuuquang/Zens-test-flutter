import 'package:zens_test_flutter/data/local/joke/joke_model.dart';
import 'package:zens_test_flutter/service/db_manager/db_manager.dart';
import 'package:zens_test_flutter/service/db_manager/joke_data_manager.dart';

class JokeRepository {
  late DBManager dbManager;

  static late final JokeRepository instance = JokeRepository._();
  bool isInitData = false;
  late JokeDataManager jokeDataManager;
  JokeRepository._() {}

  setupDatabase() async {
    if (!this.isInitData) {
      this.isInitData = true;
      this.dbManager = DBManager();

      if (await dbManager.isDbExist()) {
        print("listcontact db exist");
        await dbManager.initialize();
      } else {
        print("listcontact db not exist");
        return;
      }
      jokeDataManager = this.dbManager.jokeDataManager;
      print("initialized");
    }
  }

  insert(JokeModel joke) async {
    print('insert');
    await jokeDataManager.insert(joke);
  }

  Future<List<JokeModel>> getAll() async {
    return jokeDataManager.selectAll();
  }

  updateJoke(
    int id,
    int isFun,
  ) async {
    await jokeDataManager.update(isFun, id);
  }

  reset() async {
    await jokeDataManager.reset();
  }
}

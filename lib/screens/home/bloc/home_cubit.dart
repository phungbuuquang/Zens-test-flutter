import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zens_test_flutter/constant/constant_value.dart';
import 'package:zens_test_flutter/data/local/joke/joke_model.dart';
import 'package:zens_test_flutter/di/di.dart';
import 'package:zens_test_flutter/repository/joke_repository.dart';
import 'package:zens_test_flutter/service/storage_service/storage_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());
  late JokeRepository repository;
  List<JokeModel> jokes = [];
  initDb() async {
    try {
      repository = await JokeRepository.instance;
      await repository.setupDatabase();
    } catch (error) {
      print(error);
    }
    final isFirst = await injector.get<StorageService>().getFirstInstall();
    if (isFirst == null) {
      await injector.get<StorageService>().setFirstInstall(false);
      for (var item in ConstantValue.listContent) {
        await repository.insert(
          JokeModel(
            content: item,
          ),
        );
      }
    }
    _getFirstJoke();
  }

  _getFirstJoke() async {
    jokes = await repository.getAll();
    if (jokes.isNotEmpty) {
      emit(HomeGetJokeState(jokes.first));
    } else {
      emit(HomeEmptyJokeState());
    }
  }

  reset() async {
    await repository.reset();
    _getFirstJoke();
  }

  setFun(
    int id,
    bool isFun,
  ) async {
    await repository.updateJoke(id, isFun ? 1 : 0);
    _getFirstJoke();
  }
}

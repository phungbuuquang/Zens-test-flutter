import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zens_test_flutter/repository/joke_repository.dart';
import 'package:zens_test_flutter/screens/home/bloc/home_cubit.dart';
import 'package:zens_test_flutter/service/db_manager/db_manager.dart';
import 'package:zens_test_flutter/service/storage_service/storage_service.dart';

GetIt injector = GetIt.instance;

class DependencyInjection {
  static Future<void> inject() async {
    final shared = await SharedPreferences.getInstance();
    injector.registerSingleton<StorageService>(StorageService(shared));
  }
}

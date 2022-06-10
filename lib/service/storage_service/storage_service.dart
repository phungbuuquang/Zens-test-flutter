import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  SharedPreferences shared;
  StorageService(this.shared);

  setFirstInstall(bool isFirst) async {
    return shared.setBool('is_first', isFirst);
  }

  Future<bool?> getFirstInstall() async {
    return shared.getBool('is_first');
  }
}

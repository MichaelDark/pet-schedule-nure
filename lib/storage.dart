import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static Storage _instance = Storage._();
  static Future<SharedPreferences> get _shared => SharedPreferences.getInstance();
  factory Storage() => _instance;
  Storage._();

  Future<int> getLastGroupId() async => (await _shared).getInt('lastGroupId');

  Future<void> setLastGroupId(int groupId) async {
    (await _shared).setInt('lastGroupId', groupId);
  }

  Future<void> clear() async {
    (await _shared).clear();
  }
}
